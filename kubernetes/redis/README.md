# Redis

## Using CLI
``` bash
kubectl exec -n redis -it pod/redis-0 -- bash

# Inside Redis pod
redis-cli

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

## Redis Configuration
``` bash
# SNAPSHOTTING
save <seconds> <changes>
# save 900 1
# save 300 10
# save 60 10000

# APPEND ONLY MODE
appendonly yes

# PASSWORD
requirepass password
```