# Redis

## Redis login
``` bash
kubectl exec -n redis -it pod/redis-0 -- bash

# Inside Redis pod
redis-cli

# Authentication
# Password is stored in the secret
AUTH <password>
```