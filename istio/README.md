# Istio

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

## Install with Helm
https://istio.io/latest/docs/setup/install/helm/

**Install 3 components** \
• istio/base \
• istio/istiod \
• istio/gateway