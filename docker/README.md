## Docker

### Use the localhost of host machine inside of a Docker container
- Add the following snippet in the docker-compose.yml file
``` bash
extra_hosts:
    - "host.docker.internal:host-gateway"
```