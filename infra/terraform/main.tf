# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "development"
    application = "fullstack-devops"
  }
}

# Note: Using Docker Hub for container images instead of Azure Container Registry
# Docker Hub credentials should be configured as Kubernetes secrets when deploying applications

# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name            = "default"
    node_count      = var.node_count
    vm_size         = var.node_vm_size
    max_pods        = 30
    os_disk_size_gb = 30 # Reduced disk size
  }

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled = true

  network_profile {
    network_plugin = "kubenet" # Kubenet is more cost-effective than Azure CNI
    network_policy = "calico"
  }

  tags = {
    environment = "development"
    application = "fullstack-devops"
  }
}

# Note: AKS to ACR role assignment can be configured manually after deployment
# or by granting the service principal 'User Access Administrator' role