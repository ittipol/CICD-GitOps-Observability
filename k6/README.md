# k6

## Run k6 script
``` bash
docker-compose run --rm k6 run /k6/scripts/script_get.js

docker-compose run --rm k6 run /k6/scripts/script_post.js

docker-compose run --rm k6 run /k6/scripts/load_testing/average_load_testing.js

docker-compose run --rm k6 run /k6/scripts/load_testing/smoke_testing.js

docker-compose run --rm k6 run /k6/scripts/load_testing/soak_testing.js

docker-compose run --rm k6 run /k6/scripts/load_testing/spike_testing.js

docker-compose run --rm k6 run /k6/scripts/load_testing/stress_testing.js

docker-compose run --rm k6 run path/to/script (in container)
```