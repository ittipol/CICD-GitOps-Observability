# Redis
Redis is no longer open source

## Using CLI
``` bash
kubectl exec -n redis -it pod/redis-0 -- bash

# Inside Redis pod
redis-cli

redis-cli -a <password>

# Authentication
# Password is stored in the secret
AUTH <password>
```

## Command usage
- set https://redis.io/commands/set/
``` bash
# set key
set key value [NX|XX] [GET] [EX seconds|PX milliseconds|EXAT unix-time-seconds|PXAT unix-time-milliseconds|KEEPTTL]

# set key with expiration
setex key seconds value

# get key
get key

# delete key
del key [key ...]

# check key exist
exists key [key ...]

# find key
# keys pattern
keys *

# Delete all
flushall [ASYNC|SYNC]

# set key expiration
expire key seconds [NX|XX|GT|LT]

# Time to live
# -1 = no expiration
# -2 = key does not exist
ttl key
```

## Array
``` bash
# add item to list (append first)
lpush key element [element ...]
# ex. lpush hobbies running gardening

# print out list
lrange key start stop
# ex. lrange hobbies 0 5
# -1 = get all items in the list
# ex. lrange hobbies 0 -1

# add item to list (append last)
rpush key element [element ...]

# take item from start of list
lpop key [count]

# take item from last of list
rpop key [count]
```

## Set
``` bash
# add unique item in set
# cannot add duplicate item in set
sadd key member [member ...]
# ex. sadd hobbies "playing video game"

# print
smembers key
# ex. smembers hobbies

# remove
srem key member [member ...]
```

## Hashes
``` bash
# set
hset key field value [field value ...]

# get
hget key field

# get all
hgetall key

# delete
hdel key field [field ...]

# check exist
hexists key field
```

## Redis Persistence
### Snapshotting
**Write dataset to disk**
```
// redis.conf
save 60 100 # save after 60 seconds (1 min) if at least 100 keys have changed
```

### Append-only file (AOF)
```
// redis.conf
appendonly yes # enable AOF persistence
appendfsync always # sync AOF to disk after every write operation (safe, but slow)
```

**`appendfsync` has 3 modes**
- **always**: sync after every write operation (safe, but slow)
- **everysec**: sync every second (default option)
- **no**: never sync, let the operating system handle it (fast, but risky)

## Redis Configuration
``` bash
# Snapshotting
save <seconds> <changes>
# save 900 10
# save 300 10
# save 60 100

# Append-only file (AOF)
appendonly yes
appendfsync always

# PASSWORD
requirepass password
```

## Naming Conventions
- Keep it concise
- Use lowercase letters
- Use Delimiters for Hierarchy
- Avoid special characters

### Examples
**Convention:** entity:id:attribute
- user:100:settings
- session:5rk3JqIQkV50VjX7Ek45Y:expires
- cache:system:content

**Use `Snake_case` when a key names are composed of multiple words**
- user:100:refresh_token

## Redis cluster
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
kubectl exec -it redis-0 -n redis -- sh -c 'redis-cli --cluster create \
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
kubectl exec -it redis-0 -n redis -- sh

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