# Istio
Traffic Management https://istio.io/latest/docs/tasks/traffic-management/

## Download and install
https://istio.io/latest/docs/setup/install/istioctl/ \
https://istio.io/latest/docs/setup/additional-setup/download-istio-release/ \
https://github.com/istio/istio/releases/tag/1.25.0

``` bash
# After download Istio

# Extract tar
tar -zxvf istio-1.25.0-osx-arm64.tar.gz

# Install Istio
./istio-1.25.0/bin/istioctl install

# Install Istio for monitoring and data visualization
# - kiali
# - grafana
# - jaeger (Trace)
# - loki (Log)
# - prometheus (Metric)
kubectl apply -f ./istio-1.25.0/samples/addons
```

## Set Istio binary to environment path
1. Add Istio binary to PATH environment variable
``` bash
# Open the .bash_profile file with a text editor
code ~/.bash_profile
```
2. Use the export command to add new environment variables
``` bash
# export [existing_variable_name]=[new_variable_value]:$[existing_variable_name]
export PATH="/path/to/istio-1.25.0:${PATH}"
```
3. Execute the new .bash_profile by either restarting the terminal window or using
``` bash
source ~/.bash-profile
```
4. Check a PATH environment variable
``` bash
echo $PATH
```
5. Verify the installation
``` bash
which istioctl

istioctl
```

## Install with Helm
https://istio.io/latest/docs/setup/install/helm/

**Install 3 components** \
• istio/base \
• istio/istiod \
• istio/gateway

### Check Istio CRD (Custom Resource Definition)
``` bash
kubectl get crds | grep 'istio.io'
```

## Istiod (Control plane)
Istiod provides service discovery, configuration and certificate management

## Envoy (Data plane)
Envoy is a high-performance proxy, Designed for cloud-native applications (Sidecar proxy)

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

## Control plane
**Service mesh control plane** Provides policy and configuration for all of the running data planes in the mesh. Does not touch any packets/requests in the system. The control plane turns all of the data planes into a distributed system

## Data plane
**Service mesh data plane** Touches every packet/request in the system. Responsible for service discovery, health checking, routing, load balancing, authentication/authorization, and observability

## Service discovery
The process by which a load balancer determines the set of available backends

## Health checking
The process by which the load balancer determines if the backend is available to serve traffic

## Test access to service
### Internal access test
``` bash
while true; do curl http://auth-service-server.auth-service.svc.cluster.local:3000/version && echo "" && sleep 1; done
```

### External access test
``` bash
while true; do curl http://app.service.api/auth/version && echo "" && sleep 0.5; done

while true; do curl http://app.service.api/auth/version && echo "" && sleep 1; done

while true; do curl http://app.service.api/auth/user/profile && echo "" && sleep 1; done
```