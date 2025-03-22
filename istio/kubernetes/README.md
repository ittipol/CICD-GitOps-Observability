# Service Mesh - Ingress Gateway - Virtual Service - Gateway - Ingress - mTLS

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
    istio-injection: enabled # Set istio-injection label for injection proxy sidecar and apply to pod that match with this namespace
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

## Service to service (Internal)
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

## Client to service (External)
```
Client --> (request) --> Istio gateway --> Requested service
```