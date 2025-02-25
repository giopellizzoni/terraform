output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = azurerm_storage_account.storage-account-gp.id
}

output "sa_primary_access_key" {
  description = "The Primary Access Key for the Storage Account."
  value       = azurerm_storage_account.storage-account-gp.primary_access_key
  sensitive   = true
}
