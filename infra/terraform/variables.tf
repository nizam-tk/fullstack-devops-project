variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to use"
  type        = string
  default     = "1.34.0"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "Size of the node VMs"
  type        = string
  default     = "Standard_DC2s_v3"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

# These variables are declared to avoid warnings from Terraform Cloud
# but are not used since we use ARM_* environment variables instead
variable "AZURE_CLIENT_ID" {
  description = "Azure Service Principal Client ID (unused - using ARM_CLIENT_ID env var)"
  type        = string
  default     = ""
}

variable "AZURE_CLIENT_SECRET" {
  description = "Azure Service Principal Client Secret (unused - using ARM_CLIENT_SECRET env var)"
  type        = string
  default     = ""
}

variable "AZURE_TENANT_ID" {
  description = "Azure Tenant ID (unused - using ARM_TENANT_ID env var)"
  type        = string
  default     = ""
}

variable "AZURE_SUBSCRIPTION_ID" {
  description = "Azure Subscription ID (unused - using ARM_SUBSCRIPTION_ID env var)"
  type        = string
  default     = ""
}