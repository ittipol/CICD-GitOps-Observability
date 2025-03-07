# CI/CD • GitOps • Observability
https://landscape.cncf.io/ \
https://trivy.dev/ Use Trivy to find vulnerabilities (CVE) & misconfigurations \
https://owasp.org/www-project-top-ten/ \
https://roadmap.sh/ \
https://prometheus.io/docs/concepts/metric_types/ \
https://developer.hashicorp.com/vault/docs HashiCorp Vault

## Cloud Security
• Cloud Workload Protection Platform (CWPP) \
• Cloud Security Posture Management (CSPM) \
• Cloud Infrastructure Entitlement Management (CIEM) \
• Cloud Native Application Protection Platform (CNAPP)

## SLOs, SLIs, SLAs
https://aws.amazon.com/th/what-is/sre/

## Start a Docker
**Start a following services** \
• Jenkins \
• Docker in Docker \
• Docker Registry \
• SonarQube
``` bash
./run.sh start docker
```

## Start a Minikube
**Start a Kubernetes**
``` bash
./run.sh start minikube
```

## Add certificate for connecting to Docker registry
**Create a directory and add to this directory**
``` bash
ping $(minikube ip)

./minikube.sh cert
```

## Build Go application Docker image and push to Docker registry
### CI/CD Pipeline
**Create CI Pipeline**
1. Start Jenkins and other services by running "./run.sh start docker"
2. Navigate to http://localhost:8080
3. Click "New Item"
4. Input name and select Pipeline option
5. Click OK
6. Navigate to Definition section 
7. Use pipeline script in Jenkinsfile-ci-pipeline file
8. Paste pipeline script to textbox
9. Click Save

**Create CD Pipeline**
1. Start Jenkins and other services by running "./run.sh start docker"
2. Navigate to http://localhost:8080
3. Click "New Item"
4. Input name and select Pipeline option
5. Click OK
6. Navigate to Definition section 
7. Use pipeline script in Jenkinsfile-cd-pipeline file
8. Paste pipeline script to textbox
9. Click Save

**Run CI/CD Pipeline**
1. Navigate to http://localhost:8080
2. Select CI Pipeline item that created
3. Click "Build with Parameters"
4. Input tagVersion
5. Click Build
6. Go application will build as a Docker image and push to Docker registry

## Deploy Go application on Kubernetes
### Pull-based GitOps
**Install Argo CD**
1. Install Argo CD by running "./argocd.sh install"
2. Argo CD will install on Kubernetes

**Deploy Go application**
1. Deploy Go application by running "./gitops.sh go"
2. Go application will deploy on Kubernetes

## Deploy MySQL database on Kubernetes
1. Deploy MySQL database by running "./gitops.sh mysql"
2. MySQL database will deploy on Kubernetes

## Observability
### Visualization
**Install Grafana**
1. Install Grafana by running "./grafana.sh install"
2. Grafana will install on Kubernetes

**Install Grafana and Prometheus via kube-prometheus-stack** \
kube-prometheus-stack will apply ServiceMonitor and PodMonitor CRD (CustomResourceDefinition)
1. Install Grafana and Prometheus by running "./kube-prometheus-stack.sh install"
2. Grafana and Prometheus will install on Kubernetes

### The Three Pillars of Observability: Logs, Metrics, and Traces

### Metrics
**Install Prometheus (if not install via kube-prometheus-stack)**
1. Install Prometheus by running "./prometheus.sh install"
2. Prometheus will install on Kubernetes

**Import Grafana dashboards**
1. Import Grafana dashboards by running "./grafana.sh dashboard"
2. Dashboards will install on Grafana

**Go application container resource metrics**
1. Install cAdvisor (Container Advisor) by running "./cadvisor.sh install"
2. Apply pod monitor for pulling metrics by running "./cadvisor.sh monitor"
3. Access Grafana by running "./grafana.sh -s"
4. Go to http://localhost:3000
5. Navigate to Dashboards > cAdvisor Monitoring & k6 Load Testing Dashboard
6. This dashboard will display container resource metrics

**Go application metrics**
1. Apply service monitor for pulling metrics by running "./go_app.sh monitor"
2. Generate logs by running "./k6.sh metrics"
3. Access Grafana by running "./grafana.sh -s"
4. Go to http://localhost:3000
5. Navigate to Dashboards > Go app dashboard
6. This dashboard will display Go application metrics

### Logs
**Go application logs**
1. Install Grafana Loki by running "./loki.sh install"
2. Access Go application by running "./api_test.sh -s"
3. Generate logs by running "./k6.sh logs"
4. Access Grafana by running "./grafana.sh -s"
5. Go to http://localhost:3000
6. Navigate to Explore > Logs
7. Explore Logs will display logs that created from Go application

### Traces
**Go application Traces**
1. Install Grafana Tempo by running "./tempo.sh install"
2. Access Go application by running "./api_test.sh -s"
3. Generate traces by running "./k6.sh traces"
4. Access Grafana by running "./grafana.sh -s"
5. Go to http://localhost:3000
6. Go to Explore
7. Select tempo datasource
8. Select TraceQL
9. Type {} to input field 
10. Explore tempo will display traces that created from Go application

## OpenTelemetry Collector
**OpenTelemetry Collector pipeline has 3 steps**
```
Receivers —> Processors —> Exporters
```

**Install OpenTelemetry Collector**
1. Install OpenTelemetry Collector by running "./opentelemetry.sh install"
2. OpenTelemetry Collector will deploy on Kubernetes

**OpenTelemetry Language APIs & SDKs** \
https://opentelemetry.io/docs/languages/

**OpenTelemetry Collector config**
``` yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:4317
      http:
        endpoint: 0.0.0.0:4318
  prometheus/collector:
    config:
      scrape_configs:
        - job_name: "opentelemetry-collector"
          static_configs:
            - targets: ["localhost:8888"]

processors:
  batch:

exporters:
  otlphttp/metrics:
    endpoint: http://localhost:9090/api/v1/otlp # Prometheus
    tls:
      insecure: true
  otlphttp/traces:
    endpoint: http://localhost:4318 # Tempo
    tls:
      insecure: true
  otlphttp/logs:
    endpoint: http://localhost:3100/otlp # Loki
    tls:
      insecure: true
  debug/metrics:
    verbosity: detailed
  debug/traces:
    verbosity: detailed
  debug/logs:
    verbosity: detailed

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlphttp/traces]
      #exporters: [otlphttp/traces,debug/traces]
    metrics:
      receivers: [otlp, prometheus/collector]
      processors: [batch]
      exporters: [otlphttp/metrics]
      #exporters: [otlphttp/metrics,debug/metrics]
    logs:
      receivers: [otlp]
      processors: [batch]
      exporters: [otlphttp/logs]
      #exporters: [otlphttp/logs,debug/logs]
```

## Vault
**Install Consul**
1. Install Consul by running "./consul.sh install"
2. Consul will deploy on Kubernetes

**Install Vault**
1. Install Vault by running "./vault.sh install"
2. Vault will deploy on Kubernetes

### Database dynamic secret creation
**Enable the database engine**
``` bash
vault secrets enable database
```

## Trivy
``` bash
trivy [command] .

# Scan manifest files
trivy config ./k8s

# Scan a container image
trivy image {image:tag}
```