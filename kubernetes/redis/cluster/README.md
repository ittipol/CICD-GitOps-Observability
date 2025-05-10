# Redis cluster

**Configuration**
```
cluster-enabled yes
cluster-require-full-coverage no
cluster-node-timeout 15000
cluster-config-file /data/nodes.conf
cluster-migration-barrier 1
```

**Start Redis cluster**
``` bash
REDIS_NODES={REDIS_NODE_IP_1...6}:6379

# View Redis pod ip
kubectl get pods  -l app.kubernetes.io/name=redis -n redis -o json | grep -i "podIP"

# Require at least 6 nodes for running Redis cluster
kubectl exec -it redis-0 -n redis -- redis-cli --cluster create \
{POD_IP_0}:6379 {POD_IP_1}:6379 {POD_IP_2}:6379 \
{POD_IP_3}:6379 {POD_IP_4}:6379 {POD_IP_5}:6379 \
--cluster-replicas 1

# ex.
kubectl exec -it redis-0 -n redis -- redis-cli --cluster create \
10.244.6.132:6379 10.244.6.133:6379 10.244.6.134:6379 \
10.244.6.135:6379 10.244.6.136:6379 10.244.6.137:6379 \
--cluster-replicas 1
```

``` bash
# Use headless service to start Redis cluster
kubectl exec -it redis-0 -n redis -c redis -- sh -c 'redis-cli --cluster create \
"$POD_IP":6379 \
redis-1.redis-headless-svc-stateful.redis.svc.cluster.local:6379 \
redis-2.redis-headless-svc-stateful.redis.svc.cluster.local:6379 \
redis-3.redis-headless-svc-stateful.redis.svc.cluster.local:6379 \
redis-4.redis-headless-svc-stateful.redis.svc.cluster.local:6379 \
redis-5.redis-headless-svc-stateful.redis.svc.cluster.local:6379 \
--cluster-replicas 1'
```

**Test**
``` bash
kubectl exec -it redis-0 -n redis -c redis -- sh

redis-cli
info replication
CLUSTER INFO
```

## Headless service
**Resolving the Headless Service’s IP Address**
``` bash
curl redis-headless-svc-stateful.redis.svc.cluster.local:6379 -kv

nslookup redis-headless-svc-stateful.redis.svc.cluster.local
```

**Resolving a Specific Pod’s IP Address**
``` bash
curl redis-0.redis-headless-svc-stateful.redis.svc.cluster.local:6379 -kv

nslookup redis-0.redis-headless-svc-stateful.redis.svc.cluster.local
nslookup redis-1.redis-headless-svc-stateful.redis.svc.cluster.local
nslookup redis-2.redis-headless-svc-stateful.redis.svc.cluster.local
```