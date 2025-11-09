# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "development"
    application = "fullstack-devops"
  }
}

# Create Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                = "Basic"  # Changed to Basic SKU for cost savings
  admin_enabled      = false

  tags = {
    environment = "development"
    application = "fullstack-devops"
  }
}

# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "default"
    node_count          = 1  # Reduced to 1 node for learning/dev
    vm_size            = "Standard_B2s"  # Changed to B-series for cost optimization
    max_pods           = 30
    os_disk_size_gb    = 30  # Reduced disk size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "kubenet"  # Kubenet is more cost-effective than Azure CNI
    network_policy = "calico"
  }

  tags = {
    environment = "development"
    application = "fullstack-devops"
  }
}

# Assign AcrPull role to AKS
resource "azurerm_role_assignment" "aks_acr" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                           = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}