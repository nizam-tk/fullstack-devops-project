terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"

  cloud {
    organization = "nizam"
    workspaces {
      name = "fullstack-devops-dev"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  # Allow Azure CLI authentication for Azure DevOps pipelines
  # Will use service principal authentication via AzureCLI task
}