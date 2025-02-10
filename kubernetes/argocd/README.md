# Argo CD


## Install Argo CD
``` bash
chmod +x ./scripts/argocd.sh

./scripts/argocd.sh -i
```

## Password
``` bash
# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
./scripts/argocd.sh -p
```

## Port-forward
``` bash
# kubectl port-forward service/argocd-server -n argocd 5050:443
./scripts/argocd.sh -s 5050
```

## Login
- Username: admin
- Password: (In argocd-initial-admin-secret secret)

## Resolve to IP address
**To force cURL to use "$(minikube ip)" as the IP address when requesting "argocd.example" over port 80 (HTTP)** \
``` bash
# --resolve <host:port:address[,address]...> Resolve the host+port to this address
# -i Include protocol response headers in the output
curl --resolve "argocd.example:80:$(minikube ip)" -i http://argocd.example
```

## Credentials
### Add Git credential
1. Navigate to Settings > Repositories
2. Click Connect Repo
3. Choose your connection method: VIA HTTPS
4. Type: git
5. Input Repository URL
6. Input Username (Username, Email)
7. Input Password (Token)
