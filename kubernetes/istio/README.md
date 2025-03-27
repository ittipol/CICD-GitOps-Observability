# Service Mesh • Ingress Gateway • Virtual Service • mTLS

## Installing the Sidecar (Proxy) and enable injection to pod

**Namespace resource** \
istio-injection: enabled | disabled
``` yaml
apiVersion: v1
kind: Namespace
metadata:
  name: authentication-service
  labels: 
    istio-injection: enabled # Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application
```

**Pod resource** \
Injection on a per-pod \
sidecar.istio.io/inject: "true" | "false"
``` yaml
# Configuring the sidecar.istio.io/inject label on a pod
# Deployment
template:
  metadata:
    labels:
      version: v1
      sidecar.istio.io/inject: "true"
```

## Service to service (Internal access)
```
# Service with proxy deployed as sidecar

     Pod
+-----------+    
|           |
| Service A |
|           |
+-----------+
|  Proxy A  |
+-----------+
```

```
Service A --> Proxy A (Envoy) --> Proxy B (Envoy) --> Service B
```

## Client to service (External access)
```
Client --> (request) --> Istio gateway --> Requested service
```

## Istio gateway
- https://istio.io/latest/docs/examples/bookinfo/
- https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/#determining-the-ingress-ip-and-ports

**Edit host file**
1. Open the hosts file
``` bash
code /etc/hosts
```

2. Point a domain name to an IP address
```
127.0.0.1	app.service.api
```

3. Save the hosts file

**Connect to LoadBalancer services**
``` bash
# Tunnel creates a route to services deployed with type LoadBalancer and sets their Ingress to their ClusterIP
minikube tunnel
```

**Set the INGRESS_NAME and INGRESS_NS environment variables**
``` bash
export INGRESS_NAME=istio-gateway
export INGRESS_NS=istio-ingress

# Print service value
kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS" -o json

# INGRESS_HOST
kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS" -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

# INGRESS_PORT
kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}'

# SECURE_INGRESS_PORT
kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS" -o jsonpath='{.spec.ports[?(@.name=="https")].port}'
```

**Set the INGRESS_HOST, INGRESS_PORT and SECURE_INGRESS_PORT environment variables**
``` bash
export INGRESS_HOST=$(kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

export INGRESS_PORT=$(kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')

export SECURE_INGRESS_PORT=$(kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS" -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
```

**Set the GATEWAY_URL environment variable**
``` bash
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
```

## mTLS (Mutual TLS)
https://istio.io/latest/docs/reference/config/security/peer_authentication/

### Authentication
- Peer authentication is achieved using mTLS, while request authentication often uses tokens such as JWT (JSON Web Tokens)

There are two types of authentication provided by Istio
- **Peer Authentication** For service-to-service authentication
- **Request Authentication** For end-user authentication. Using JSON Web Tokens (JWT)

### Examples
**To apply policy enforces mTLS for all services (pod) in the `auth-service` namespace**
``` yaml
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: auth-service-peer-authentication
  namespace: auth-service
spec:
  mtls:
    mode: STRICT
```

**Lock down workloads in all namespaces to only accept mutual TLS traffic by putting the policy in the system namespace of your Istio installation**
``` yaml
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: peer-authentication
  namespace: istio-system # Istio installation namespace
spec:
  mtls:
    mode: STRICT
```

## Circuit breakers
**Circuit breakers are configured using Destination Rules**
``` yaml
# DestinationRule
trafficPolicy:  
  connectionPool:  
    tcp:  
      maxConnections: 2  
    http:  
      http1MaxPendingRequests: 1  
      maxRequestsPerConnection: 1  
  outlierDetection:  
    consecutive5xxErrors: 2  
    interval: 10s # If the auth service encounters 2 consecutive 5xx errors within 10 seconds, it will be ejected for 30 seconds
    baseEjectionTime: 30s # After 30 seconds, the circuit enters a half-open state to test recovery
```

## Request Timeouts
**Circuit Breaker with Timeout**
``` yaml
# VirtualService
http:
- name: "auth-service-route"
  match:
  - uri:
      prefix: /
  timeout: 5s # 5 second timeout for requests to the auth service. If the service does not respond within this time, the request will fail gracefully
  route:
  - destination:
      host: auth-service-server.auth-service.svc.cluster.local
      subset: v1
    weight: 90
  - destination:
      host: auth-service-server.auth-service.svc.cluster.local
      subset: v2
    weight: 10
```