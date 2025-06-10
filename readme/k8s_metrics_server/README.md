# Metrics server
**Install On Kubernetes v1.21+**
``` bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/high-availability-1.21+.yaml
```

**Check metric server running**
``` bash
kubectl get apiservices | grep -i metric

# View column "AVAILABLE"
# if False then fix it to True
```

**Fixing AVAILABLE value is False**
``` bash
# Edit (vim)
kubectl edit deployment metrics-server -n kube-system
```

**Vim command**
``` bash
i --> insert before the cursor
Esc or Ctrl + c --> exit insert mode
:w --> write (save) the file, but don't exit
:wq or :x or ZZ --> write (save) and quit
:q --> quit (fails if there are unsaved changes)
:q! or ZQ --> quit and throw away unsaved changes
```

``` yaml
# deployment
containers:
- args:
    - --cert-dir=/tmp
    - --secure-port=10250
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --kubelet-use-node-status-port
    - --metric-resolution=15s
    - --kubelet-insecure-tls # Add this argument
```

**Check after fixing**
``` bash
kubectl get deployment -n kube-system

kubectl get apiservices | grep -i metric
# View column "AVAILABLE"
# Value will be True
```