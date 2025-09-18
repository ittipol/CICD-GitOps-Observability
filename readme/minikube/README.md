## View config (local machine use)

``` bash
cat ~/.kube/config
```

## Copy these 3 files from remote VM to your target machine
1. ca.crt (usually found at ~/.minikube/profiles/minikube/ca.crt)
2. client.crt (usually found at ~/.minikube/profiles/minikube/client.crt)
3. client.key (usually found at ~/.minikube/profiles/minikube/client.key)

## Encode these 3 files to base64
``` bash
base64 -i <input-file> -o <output-file>
```

## Update config

``` yaml
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/11356904/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Thu, 18 Sep 2025 08:47:58 +07
        provider: minikube.sigs.k8s.io
        version: v1.34.0
      name: cluster_info
    server: https://127.0.0.1:32781
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Thu, 18 Sep 2025 08:47:58 +07
        provider: minikube.sigs.k8s.io
        version: v1.34.0
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /Users/11356904/.minikube/profiles/minikube/client.crt
    client-key: /Users/11356904/.minikube/profiles/minikube/client.key
```