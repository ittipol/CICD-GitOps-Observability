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
``` bash
curl --resolve "argocd-server:80:$(minikube ip)" -i http://argocd.example
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