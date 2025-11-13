# Monitoring Deployment Instructions

## Prerequisites
1. Ensure your AKS cluster is running
2. Install Helm on your local machine: https://helm.sh/docs/intro/install/
3. Add Prometheus community Helm repository

## Installation Steps

### 1. Add Helm Repository
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

### 2. Install Prometheus & Grafana Stack
```bash
# Create monitoring namespace
kubectl create namespace monitoring

# Install kube-prometheus-stack (includes Prometheus, Grafana, and Alertmanager)
helm install prometheus prometheus-community/kube-prometheus-stack \
  -f k8s/monitoring/helm/prometheus-values.yaml \
  -n monitoring
```

### 3. Access Grafana
```bash
# Get LoadBalancer IP (may take a few minutes)
kubectl get svc prometheus-grafana -n monitoring

# Default credentials:
# Username: admin
# Password: admin (as set in prometheus-values.yaml)
```

### 4. Verify Installation
```bash
# Check all pods are running
kubectl get pods -n monitoring

# Check services
kubectl get svc -n monitoring
```

## Default Services Exposed
- **Grafana**: LoadBalancer on port 80 (for dashboards)
- **Prometheus**: ClusterIP on port 9090 (internal only)
- **Alertmanager**: ClusterIP on port 9093 (internal only)

## Customization
Edit `k8s/monitoring/helm/prometheus-values.yaml` to:
- Change Grafana admin password
- Adjust resource limits
- Configure retention periods
- Enable/disable components

## Upgrade Configuration
```bash
helm upgrade prometheus prometheus-community/kube-prometheus-stack \
  -f k8s/monitoring/helm/prometheus-values.yaml \
  -n monitoring
```

## Uninstall
```bash
helm uninstall prometheus -n monitoring
kubectl delete namespace monitoring
```

## Pre-configured Dashboards
Grafana comes with built-in dashboards for:
- Kubernetes cluster monitoring
- Node metrics
- Pod metrics
- Persistent volumes
- API server metrics

Access Grafana → Dashboards → Browse to see all available dashboards.
