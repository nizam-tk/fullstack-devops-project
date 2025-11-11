resource_group_name = "rg-fullstack-dev"
location            = "eastus"
cluster_name        = "aks-fullstack-dev"
kubernetes_version  = "1.34.0"
node_count          = 1
node_vm_size        = "Standard_DC2s_v3"
acr_name            = "acrfullstackdev" # ACR name must be globally unique and lowercase alphanumeric