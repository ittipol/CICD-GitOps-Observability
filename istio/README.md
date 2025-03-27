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