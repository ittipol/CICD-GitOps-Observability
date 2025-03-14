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
kube-prometheus-stack will automatically install ServiceMonitor and PodMonitor CRD (CustomResourceDefinition)
1. Install Grafana and Prometheus by running "./kube-prometheus-stack.sh install"
2. Grafana and Prometheus will install on Kubernetes

**Manually Install ServiceMonitor and PodMonitor CRD** \
https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack/charts/crds/crds
``` bash
# Install ServiceMonitor CRD
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.80.1/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml

# Install PodMonitor CRD
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.80.1/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
```

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
2. OpenTelemetry Collector will install on Kubernetes

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

## Vault (Secrets management)
https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-minikube-raft
https://developer.hashicorp.com/vault/tutorials/kubernetes/kubernetes-minikube-consul

**Install Consul**
1. Install Consul by running "./consul.sh install"
2. Consul will install on Kubernetes

**Install Vault**
1. Install Vault by running "./vault.sh install"
2. Vault will install on Kubernetes

### Manage a key
**Enable the kv engine**
``` bash
vault secrets enable -path=key kv
```

**Add JWT secret key**
``` bash
vault kv put -mount=key jwt-secret-key jwt-access-token-secret=uDnF3+6uGj+tyvqRrzfCqc1czsKOnW8m+xv7lnOBDzuIGIkjphTa6aGjuQbbMQ79EAI22YU7bTfhTQzyqKMgBQ== jwt-refresh-token-secret=0Cf7yuCqusHqFW2N5eWZ88dy4bukCK19/jFdNIP1XvHR7zEiCDa04yf4JUqCX5TMRFaELd4ERLMcIFUB8aMXjg==
```

**Create a policy**
``` bash
vault policy write jwt-secret-key-policy - <<EOF
path "key/jwt-secret-key" {
  capabilities = ["read"]
}
EOF
```

### Database dynamic secret creation
**Enable the database engine**
``` bash
vault secrets enable database
```

**Install Postgresql**
``` bash
./postgresql.sh install
```

**Create a database configuration**
``` bash
vault write database/config/postgresdb \
    plugin_name=postgresql-database-plugin \
    allowed_roles="sql-create-user-role" \
    allowed_roles="sql-all-access-role" \
    connection_url="postgresql://{{username}}:{{password}}@postgresql.postgresql.svc:5432/postgresdb?sslmode=disable" \
    username="admin" \
    password="password1234"
```

**Create a database role**
``` bash
vault write database/roles/sql-create-user-role \
    db_name=postgresdb \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN ENCRYPTED PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
        GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO \"{{name}}\"; \
        GRANT SELECT, UPDATE, INSERT, DELETE ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
    default_ttl="1h" \
    max_ttl="24h"

vault write database/roles/sql-all-access-role \
    db_name=postgresdb \
    creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN ENCRYPTED PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; \
        GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO \"{{name}}\"; \
        GRANT ALL PRIVILEGES ON SCHEMA public TO \"{{name}}\"; \
        GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
    default_ttl="1h" \
    max_ttl="24h"
```

**Test database role**
``` bash
# Shell into Vault pod
kubectl exec -it vault-0 -n vault -- sh

# Generate a username and password
vault read database/creds/sql-create-user-role

# Generate a username and password
vault read database/creds/sql-all-access-role

# Shell into Postgresql pod
kubectl exec -it postgresql-0 -n postgresql -- sh

# Login to Postgresql
psql -U admin -d postgresdb

# Display Postgresql user
\du
```

**Create a policy**
``` bash
vault policy write database-only-read-policy - <<EOF
path "database/creds/sql-create-user-role" {
  capabilities = ["read"]
}
EOF

vault policy write sql-all-access-role-policy - <<EOF
path "database/creds/sql-all-access-role" {
  capabilities = ["read"]
}
EOF
```

### Bind a role to a Kubernetes
**Enable the Kubernetes authentication**
``` bash
vault auth enable kubernetes
```

**Create a Kubernetes configuration**
``` bash
vault write auth/kubernetes/config \
    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
    kubernetes_host=https://${KUBERNETES_PORT_443_TCP_ADDR}:443 \
    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

**Bind a role to a Kubernetes service account**
``` bash
vault write auth/kubernetes/role/sql-create-user-role \
   bound_service_account_names=go-app-sa \
   bound_service_account_namespaces=go-app \
   policies=database-only-read-policy \
   ttl=1h

vault write auth/kubernetes/role/multiple-role \
   bound_service_account_names=go-app-sa \
   bound_service_account_namespaces=go-app \
   policies=database-only-read-policy \
   policies=jwt-secret-key-policy \
   ttl=1h
```

**Inject a secret to a pod**
``` yaml
# Deployment
annotations:
  vault.hashicorp.com/agent-inject: "true"
  vault.hashicorp.com/tls-skip-verify: "true"
  vault.hashicorp.com/agent-inject-secret-sql-create-user-role: "database/creds/sql-create-user-role"
  vault.hashicorp.com/agent-inject-template-sql-create-user-role: |
    {
    {{- with secret "database/creds/sql-create-user-role" -}}
      "db_connection": "host=postgresql.postgresql.svc port=5432 user={{ .Data.username }} password={{ .Data.password }} dbname=postgresdb sslmode=disable TimeZone=Asia/Bangkok"
    {{- end }}
    }
  vault.hashicorp.com/agent-inject-secret-jwt-secret-key : "key/jwt-secret-key"
  # vault.hashicorp.com/agent-inject-template-jwt-secret-key: |
  #   {{- with secret "key/jwt-secret-key" -}}
  #     {{ range $k, $v := .Data }}
  #       {{ $k }}: {{ $v }}
  #     {{ end }}
  #   {{- end }}
  vault.hashicorp.com/agent-inject-template-jwt-secret-key: |
    {{- with secret "key/jwt-secret-key" -}}
      {{ .Data | toJSON }}
    {{- end }}
  vault.hashicorp.com/role: "multiple-role"
```

**View a secret in a pod**
``` bash
kubectl exec -it {pod_name} -n go-app -c go-app -- sh

cat /vault/secrets/sql-create-user-role

cat /vault/secrets/jwt-secret-key
```

**Create a token for creating database username and password for developing or testing**
``` bash
vault token create -period=1h -ttl=24h -policy=database-only-read-policy

vault token create -period=1h -ttl=24h -policy=sql-all-access-role-policy

vault token create -period=1h -ttl=24h -policy=database-only-read-policy -policy=sql-all-access-role-policy
```

## Trivy
Use Trivy to find vulnerabilities (CVE) & misconfigurations
``` bash
trivy [command] .

# Scan manifest files
trivy config ./k8s

# Scan a container image
trivy image {image:tag}
```