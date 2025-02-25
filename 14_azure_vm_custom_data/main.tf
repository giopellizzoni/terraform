terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-remote-state"
    storage_account_name = "giopelltfstate"
    container_name       = "gptfremotestate"
    key                  = "azure-vm-custom-data/terraform.tfstate"
  }
}


provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-remote-state"
    storage_account_name = "giopelltfstate"
    container_name       = "gptfremotestate"
    key                  = "azure-vnet/terraform.tfstate"
  }
}
