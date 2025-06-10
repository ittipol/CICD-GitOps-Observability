# k6
- https://grafana.com/load-testing/types-of-load-testing/
- https://grafana.com/docs/k6/latest/
- https://grafana.com/docs/k6/latest/using-k6/
- https://grafana.com/docs/k6/latest/testing-guides/automated-performance-testing/
- https://grafana.com/docs/k6/latest/using-k6/scenarios/advanced-examples/
- https://grafana.com/docs/k6/latest/javascript-api/
- https://grafana.com/docs/k6/latest/using-k6/scenarios/

## SLIs, SLOs, SLAs
- Service level indicators (SLIs)
- Service level objectives (SLOs)
- Service level agreements (SLAs)

### SLIs, SLOs Metric
- Latency (Request duration)
- Error Rate
- Throughput
- Availability

Metric | Threshold | Description
--- | --- | ---
Latency (90th percentiles) | <= 200ms | The service will have 90th percentiles response time <= 200 ms
Latency (95th percentiles) | <= 500ms | The service will have 90th percentiles response time <= 500 ms
Error Rate | < 1% | Average of a period of time the error rate for the service will be less than 1%
Throughput | 1000 requests per second | The service can handle 1,000 requests per second 
Availability | 99.9% (99.9% of a month) | An Availability of 99.9% means for no more than a total of 1 hour per month the service will be down

### SLIs Definition
- 95th percentiles latency less than 500ms

### SLOs Definition
- 95th percentiles latency less than 500ms will succeed 99.9% over 30-day rolling window

## Type of load testing

Type | Throughput | Duration
--- | --- | ---
Smoke test | Low | Short (seconds or minutes)
Average-load test | Average production | Mid (5-60 minutes)
Stress test | High (above average) | Mid (5-60 minutes)
Soak test | Average | Long (hours)
Spike test | Very high | Short (a few minutes)
Breakpoint test | Increases until break | As long as necessary

## k6 Scenarios
``` javascript
export const options = {
  scenarios: {
    scenario_a: {
      //
    },
    scenario_b: {
      //
    },
  },
};
```

### Scenario executors
**By number of iterations**
- shared-iterations
- per-vu-iterations

**By number of VUs**
- constant-VUs
- ramping-vus

**By iteration rate**
- constant-arrival-rate
- ramping-arrival-rate

## Report
``` bash
scenarios: (100.00%) 1 scenario, 1 max VUs, 1h0m30s max duration (incl. graceful stop):
              * content: 1000 iterations for each of 1 VUs (maxDuration: 1h0m0s, gracefulStop: 30s)

     ✓ status is 200

     checks.........................: 100.00% 1000 out of 1000
     data_received..................: 521 kB  518 B/s
     data_sent......................: 96 kB   95 B/s
     http_req_blocked...............: avg=13.9µs  min=2µs    med=13µs    max=563µs   p(90)=18µs   p(95)=20µs    
     http_req_connecting............: avg=193ns   min=0s     med=0s      max=193µs   p(90)=0s     p(95)=0s      
   ✓ http_req_duration..............: avg=5.06ms  min=1.23ms med=5.26ms  max=17.79ms p(90)=6.99ms p(95)=7.47ms  
       { expected_response:true }...: avg=5.06ms  min=1.23ms med=5.26ms  max=17.79ms p(90)=6.99ms p(95)=7.47ms  
   ✓ http_req_failed................: 0.00%   0 out of 1000
     http_req_receiving.............: avg=123.6µs min=25µs   med=126.5µs max=1.59ms  p(90)=176µs  p(95)=193.05µs
     http_req_sending...............: avg=44.45µs min=9µs    med=44µs    max=1.87ms  p(90)=59µs   p(95)=63µs    
     http_req_tls_handshaking.......: avg=0s      min=0s     med=0s      max=0s      p(90)=0s     p(95)=0s      
     http_req_waiting...............: avg=4.9ms   min=1.19ms med=5.08ms  max=17.4ms  p(90)=6.77ms p(95)=7.23ms  
     http_reqs......................: 1000    0.993763/s
     iteration_duration.............: avg=1s      min=1s     med=1s      max=1.01s   p(90)=1s     p(95)=1s      
     iterations.....................: 1000    0.993763/s
     vus............................: 1       min=1            max=1
     vus_max........................: 1       min=1            max=1


running (0h16m46.3s), 0/1 VUs, 1000 complete and 0 interrupted iterations
scenario_a ✓ [======================================] 1 VUs  0h16m46.3s/1h0m0s  1000/1000 iters, 1000 per VU
```

**Report data**
``` bash
http_req_duration..............: avg=5.06ms  min=1.23ms med=5.26ms  max=17.79ms p(90)=6.99ms p(95)=7.47ms
```
- average: avg
- minimum: min
- median: med
- maximum: max
- percentiles: p(90), p(95)

`p(90)=6.99ms`\
90% of all HTTP requests have a response time equal 6.99ms

`p(95)=7.47ms`\
95% of all HTTP requests have a response time equal 7.47ms

## Threshold
``` javascript
thresholds: {
  http_req_duration: ['p(90) < 200'],
  http_req_duration: ['p(95) < 500'],
  http_req_duration: ['p(99.9) < 1000'],
},
```
`90%` of all HTTP requests should have a response time `lower than 200 ms` \
`95%` of all HTTP requests should have a response time `lower than 500 ms` \
`99.9%` of all HTTP requests should have a response time `lower than 1000 ms`

## Scaling strategy
**When one server hits its limit, it risk slow responses, errors or full downtime**
- `Vertical scaling:` upgrade server resources
- `Horizontal scaling:` add more servers behind a load balancer

### Horizontal scaling
**Running load testing, 1 instance vs 5 instance**
1. 10 vus and 10m duration with 1 instance
    -  Result: Throughput, Latency
2. 10 vus and 10m duration with 5 instance
    - Result: Throughput, Latency

### Fixing performance issue
1. Code optimization
2. Scaling
3. Distribute workloads across multiple instance

## Run a script
``` bash
docker-compose run --rm k6 run /scripts/script_get.js

docker-compose run --rm k6 run /scripts/script_post.js

docker-compose run --rm k6 run /scripts/type/average_load_testing.js

docker-compose run --rm k6 run /scripts/type/smoke_testing.js

docker-compose run --rm k6 run /scripts/type/soak_testing.js

docker-compose run --rm k6 run /scripts/type/spike_testing.js

docker-compose run --rm k6 run /scripts/type/stress_testing.js

docker-compose run --rm k6 run path/to/script (in container)
```

## Pod watch
``` bash
kubectl get po -n <namespace> --watch
```