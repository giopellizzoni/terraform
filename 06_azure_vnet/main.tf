terraform {
  required_version = ">= 1.9.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-remote-state"
    storage_account_name = "giopelltfstate"
    container_name       = "gptfremotestate"
    key                  = "azure-vnet/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}

}
