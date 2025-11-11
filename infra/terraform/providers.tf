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

  # Explicitly disable other authentication methods to use only service principal
  use_cli                = false
  use_msi                = false
  use_oidc               = false

  # Authentication will use environment variables:
  # ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID
}