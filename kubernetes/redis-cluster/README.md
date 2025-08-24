# Redis cluster

``` bash
kubectl get all -n redis-cluster-node

kubectl describe pod redis-node0-0 -n redis-cluster-node

kubectl port-forward svc/redis-service-node1 -n redis-cluster-node 7001:7001
```

``` bash
kubectl exec -it redis-node0-0 -n redis-cluster-node -c redis -- sh

redis-cli -p 7000

auth password
```

``` bash
# Use headless service to start Redis cluster
kubectl exec -it redis-node0-0 -n redis-cluster-node -c redis -- sh -c 'redis-cli --cluster create \
"$POD_IP":7000 \
redis-node1-0.redis-service-node1:7001 \
redis-node2-0.redis-service-node2:7002 \
redis-node3-0.redis-service-node3:7003 \
redis-node4-0.redis-service-node4:7004 \
redis-node5-0.redis-service-node5:7005 \
--cluster-replicas 1'
```

**Test**
``` bash
kubectl exec -it redis-node0-0 -n redis-cluster-node -c redis -- sh

redis-cli -p 7000

cluster nodes
info replication
CLUSTER INFO
```