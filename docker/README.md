## Docker

### Use the localhost of host machine inside of a Docker container
- Add the following snippet in the docker-compose.yml file
``` bash
extra_hosts:
    - "host.docker.internal:host-gateway"
```

### Docker commands
``` bash
# Display all process
docker ps -a
docker ps -a -q

docker stop {container_id}
docker rm {container_id}

# Stop all the containers
docker stop $(docker ps -a -q)

# Remove all the containers
docker rm $(docker ps -a -q)

# Delete unused docker images
docker system prune -a

# Delete all
docker system prune --force --all --volumes

# Remove all unused volumes
docker system prune --volumes

# list all existing volumes
docker volume ls

# remove a specific volume
docker volume rm <volume_name>

# remove unused volumes
docker volume prune

docker volume prune -f

# remove volumes with a container
docker rm -v <container_name_or_id>

# Remove dangling volumes
docker volume rm $(docker volume ls -qf dangling=true)
```