# Service Mesh • Ingress Gateway • Virtual Service • Gateway • Ingress • mTLS

## Istiod
Istiod provides service discovery, configuration and certificate management

## Envoy
Envoy is a high-performance proxy, Designed for cloud-native applications

**Envoy’s built-in features** \
• Dynamic service discovery \
• Load balancing \
• TLS termination \
• HTTP/2 and gRPC proxies \
• Circuit breakers \
• Health checks \
• Staged rollouts with %-based traffic split \
• Fault injection \
• Rich metrics

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

## Test access to service
### Internal access test
``` bash
while true; do curl http://auth-service-server.auth-service.svc.cluster.local:3000/version && echo "" && sleep 1; done
```

### External access test
``` bash
while true; do curl http://app.service.api/version && echo "" && sleep 0.5; done

while true; do curl http://app.service.api/version && echo "" && sleep 1; done

while true; do curl http://app.service.api/user/profile && echo "" && sleep 1; done
```