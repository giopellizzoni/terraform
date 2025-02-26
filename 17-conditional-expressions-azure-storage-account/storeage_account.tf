resource "azurerm_resource_group" "rg-storage-account-gp" {
  name     = "rg-${var.envinronment}"
  location = var.location

  tags = local.common_tags
}

resource "azurerm_storage_account" "storage-account-gp" {
  count = var.envinronment == "dev" ? 0 : 1

  name                     = "giopellizzoni${var.envinronment}"
  resource_group_name      = azurerm_resource_group.rg-storage-account-gp.name
  location                 = var.location
  account_tier             = var.envinronment == "prod" ? "Premium" : "Standard"
  account_replication_type = var.envinronment == "dev" ? "RAGZRS" : "LRS"

  tags = local.common_tags
}
