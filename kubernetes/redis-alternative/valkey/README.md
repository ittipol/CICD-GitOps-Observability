# Valkey

## Using CLI
``` bash
kubectl exec -n valkey -it pod/valkey-0 -- bash

# Inside Valkey pod
valkey-cli

valkey-cli -a <password>

# Authentication
# Password is stored in the secret
AUTH <password>
```

## Test connection by using the CLI
``` bash
valkey-cli ping
```

**Start Valkey cluster**
``` bash
VALKEY_NODES={VALKEY_NODE_IP_1...6}:6379

# View Valkey pod ip
kubectl get pods  -l app.kubernetes.io/name=valkey -n valkey -o json | grep -i "podIP"

# Require at least 6 nodes for running Valkey cluster
kubectl exec -it valkey-0 -n valkey -- valkey-cli --cluster create \
{POD_IP_0}:6379 {POD_IP_1}:6379 {POD_IP_2}:6379 \
{POD_IP_3}:6379 {POD_IP_4}:6379 {POD_IP_5}:6379 \
--cluster-replicas 1

# ex.
kubectl exec -it valkey-0 -n valkey -- valkey-cli --cluster create \
10.244.6.132:6379 10.244.6.133:6379 10.244.6.134:6379 \
10.244.6.135:6379 10.244.6.136:6379 10.244.6.137:6379 \
--cluster-replicas 1
```

``` bash
# Use headless service to start Valkey cluster
kubectl exec -it valkey-0 -n valkey -- sh -c 'valkey-cli --cluster create \
"$POD_IP":6379 \
valkey-1.valkey-headless-svc-stateful.valkey.svc.cluster.local:6379 \
valkey-2.valkey-headless-svc-stateful.valkey.svc.cluster.local:6379 \
valkey-3.valkey-headless-svc-stateful.valkey.svc.cluster.local:6379 \
valkey-4.valkey-headless-svc-stateful.valkey.svc.cluster.local:6379 \
valkey-5.valkey-headless-svc-stateful.valkey.svc.cluster.local:6379 \
--cluster-replicas 1'
```

**Test**
``` bash
kubectl exec -it valkey-0 -n valkey -- sh

valkey-cli
info replication
CLUSTER INFO
```

## Headless service
**Resolving the Headless Service’s IP Address**
``` bash
curl valkey-headless-svc-stateful.valkey.svc.cluster.local:6379 -kv

nslookup valkey-headless-svc-stateful.valkey.svc.cluster.local
```

**Resolving a Specific Pod’s IP Address**
``` bash
curl valkey-0.valkey-headless-svc-stateful.valkey.svc.cluster.local:6379 -kv

nslookup valkey-0.valkey-headless-svc-stateful.valkey.svc.cluster.local
nslookup valkey-1.valkey-headless-svc-stateful.valkey.svc.cluster.local
nslookup valkey-2.valkey-headless-svc-stateful.valkey.svc.cluster.local
```