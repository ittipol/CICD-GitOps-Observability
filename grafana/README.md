# Grafana

## Exporting Datasource
- http://{grafana-hostname}:{grafana-port}/api/datasources
- ex. http://localhost:3000/api/datasources

## Create Grafana dashboard config map
``` bash
kubectl create configmap cadvisor-k6-dashboard --from-file=./cadvisor-k6-dashboard.json -n monitoring
```

## Apply Grafana dashboard config map
``` bash
kubectl apply -f cadvisor-k6-dashboard.yaml
```