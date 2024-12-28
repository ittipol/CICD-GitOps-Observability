# Docker Registry

``` bash
# Get repo
# {host_name}/v2/_catalog?n={page_size}
curl -u docker:1234 --cacert /docker_registry/cert/server.crt -X GET https://registry:5000/v2/_catalog?n=100

# Get tags
# {host_name}/v2/{repo}/tags/list
curl -u docker:1234 --cacert /docker_registry/cert/server.crt -X GET https://registry:5000/v2/go-app/tags/list

# Get digest
# {host_name}/v2/{repo}/manifests/{tag}
curl -u docker:1234 --cacert /docker_registry/cert/server.crt -X GET https://registry:5000/v2/go-app/manifests/1.0.0
```

## Pull an image from private registry
``` bash
# Login
docker login -u docker -p 1234 host.docker.internal:5050

# docker image pull {repo}:{tag} 
docker image pull host.docker.internal:5050/go-app:1.0.0
```