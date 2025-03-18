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
