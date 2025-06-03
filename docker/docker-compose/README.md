## Docker compose

### Config
**Specific a Dockerfile**
``` yaml
# under the service
services:
  order-service:
    build: 
      context: <folder of your project>
      dockerfile: <path and name to your Dockerfile>
    container_name: order-service
    ports:
      - 6068:6068
```