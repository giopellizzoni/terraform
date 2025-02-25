resource "azurerm_resource_group" "rg-storage-account-gp" {
  name     = var.resource_group_name
  location = var.location

  tags = local.common_tags
}

resource "azurerm_storage_account" "storage-account-gp" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg-storage-account-gp.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = local.common_tags
}

resource "azurerm_storage_container" "container-gp" {
  name               = var.storage_container_name
  storage_account_id = azurerm_storage_account.storage-account-gp.id
}

