# k6
- https://grafana.com/load-testing/types-of-load-testing/
- https://grafana.com/docs/k6/latest/
- https://grafana.com/docs/k6/latest/testing-guides/automated-performance-testing/
- https://grafana.com/docs/k6/latest/using-k6/scenarios/advanced-examples/
- https://grafana.com/docs/k6/latest/javascript-api/

## SLOs, SLIs, SLAs
- Service level objectives (SLOs)
- Service level indicators (SLIs)
- Service level agreements (SLAs)

## Type of load testing
1. Smoke test
    - Throughput: Low
    - Duration: Short (seconds or minutes)
2. Average-load test
    - Throughput: Average production
    - Duration: Mid (5-60 minutes)
3. Stress test
    - Throughput: High (above average)
    - Duration: Mid (5-60 minutes)
4. Spike test
    - Throughput: Average
    - Duration: Long (hours)
5. Breakpoint test
    - Throughput: Very high
    - Duration: Short (a few minutes)
6. Soak test
    - Throughput: Increases until break
    - Duration: As long as necessary

## Run k6 script
``` bash
docker-compose run --rm k6 run /scripts/script_get.js

docker-compose run --rm k6 run /scripts/script_post.js

docker-compose run --rm k6 run /scripts/load_testing/average_load_testing.js

docker-compose run --rm k6 run /scripts/load_testing/smoke_testing.js

docker-compose run --rm k6 run /scripts/load_testing/soak_testing.js

docker-compose run --rm k6 run /scripts/load_testing/spike_testing.js

docker-compose run --rm k6 run /scripts/load_testing/stress_testing.js

docker-compose run --rm k6 run path/to/script (in container)
```
