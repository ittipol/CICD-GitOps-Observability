# k6

## Run k6 script
``` bash
docker-compose run --rm k6 run /k6/scripts/script_get.js

docker-compose run --rm k6 run /k6/scripts/script_post.js

docker-compose run --rm k6 run /k6/scripts/loading_testing/smoke_testing.js

docker-compose run --rm k6 run /k6/scripts/loading_testing/average_load_testing.js

docker-compose run --rm k6 run /k6/scripts/loading_testing/soak_testing.js

docker-compose run --rm k6 run path/to/script (in container)
```