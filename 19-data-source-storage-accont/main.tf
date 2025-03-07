terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.22.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-gp-tf-state"
    storage_account_name = "giopelterraformstate"
    container_name       = "remote-state"
    key                  = "data-source.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

