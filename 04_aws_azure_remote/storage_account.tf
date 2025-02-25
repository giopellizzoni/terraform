resource "azurerm_resource_group" "rg-remote-state" {
  name     = "rg-remote-state"
  location = var.location

  tags = local.common_tags
}

resource "azurerm_storage_account" "sta-remote-state" {
  name                     = "giopelltfstate"
  resource_group_name      = azurerm_resource_group.rg-remote-state.name
  location                 = azurerm_resource_group.rg-remote-state.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  blob_properties {
    versioning_enabled = true
  }

  tags = local.common_tags
}

resource "azurerm_storage_container" "ctnr_remote_state" {
  name                  = "gptfremotestate"
  storage_account_name  = azurerm_storage_account.sta-remote-state.name
  container_access_type = "private"
}

