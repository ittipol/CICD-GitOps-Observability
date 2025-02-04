# CI/CD, GitOps, Observability
https://landscape.cncf.io/\
https://trivy.dev/ Use Trivy to find vulnerabilities (CVE) & misconfigurations\
https://owasp.org/www-project-top-ten/\
https://roadmap.sh/

## Start a Docker
``` bash
# Start a following services
# Jenkins
# Docker in Docker
# Docker Registry
# SonarQube
./run.sh start docker
```

## Start a Minikube
``` bash
# Start a Kubernetes
./run.sh start minikube
```

## GitOps
``` bash
# Install Argo CD
./argocd.sh -i

# Argo CD password
./argocd.sh -p
```

## Observability
The Three Pillars of Observability: Logs, Metrics, and Traces

### Metrics
``` bash
# Install Grafana & Prometheus
./prometheus.sh install
```

### Logs
``` bash
# Install Grafana Loki
./loki.sh install
```

### Traces
``` bash
# Install Grafana Tempo
./tempo.sh install

# Jaeger
```

 
## Visualization
``` bash
# Install Grafana & Prometheus
./prometheus.sh install
```

## Collector
``` bash
# Install OpenTelemetry Collector
./opentelemetry.sh install
```
- Metric
    - Prometheus Exporter
- Log
    - Promtail
- Trace
    - OpenTelemetry

## load testing

### k6
``` bash
# Run k6 script
docker-compose run --rm k6 run path/to/script (in container)
```