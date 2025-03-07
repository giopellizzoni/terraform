output "sas_token" {
  description = "The SAS token for the images storage account"
  value       = data.azurerm_storage_account_blob_container_sas.sas_token.sas
  sensitive   = true
}

output "container_url" {
  description = "The URL of the images storage account"
  value       = azurerm_storage_container.container.id
}
