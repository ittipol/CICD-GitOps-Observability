# Grafana

## Exporting Datasource
- http://{grafana-hostname}:{grafana-port}/api/datasources
- ex. http://localhost:3000/api/datasources

## Create Grafana dashboard config map
``` bash
kubectl create configmap cadvisor-k6-dashboard --from-file=./cadvisor-k6-dashboard.json -n monitoring

kubectl create configmap go-app-dashboard --from-file=./go-app-dashboard.json -n monitoring
```

## Apply Grafana dashboard config map
``` bash
kubectl apply -f cadvisor-k6-dashboard.yaml
```

## PromQL
**Example metrics**
```
Time Count increase  rate(count[1m])
15s  4381  0          0
30s  4381  0          0
45s  4381  0          0
1m   4381  0          0

15s  4381  0          0
30s  4402  21         0.700023
45s  4402  0          0.700023
2m   4423  21         0.7

15s  4423  0          0.7
30s  4440  17         0.56666666
45s  4440  0          0.56666666
3m   4456  16         0.53333333
```

**rate()** \
• Calculates the amount per second the measure grows \
• rate(v range-vector) \
• rate(go_app_http_requests_total[1m]) is the number of requests that occurred during 1 minutes, divided by 1 minutes
```
# example
rate[1m] = (count at 2m - count at 1m) / 60 = (4423 - 4381) / 60 = 0.7

rate[5m] = (count at now - count at {now-5m}) / (5m = 5*60)
```

**increase()** \
• Calculates how much some counter has grown \
• increase(v range-vector) \
• increase(go_app_http_requests_total[1m])
```
# example
increase[15s] = count at 2m - count at {1m45s} = 4423 - 4402 = 21
```