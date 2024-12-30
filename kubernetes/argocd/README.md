# Argo-CD

## Password
### Get password
``` bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## Port-forward
``` bash
kubectl port-forward service/argocd-server -n argocd 8080:443
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