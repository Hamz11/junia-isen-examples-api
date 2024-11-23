output "storage_account_name" {
  value = azurerm_storage_account.blob_storage.name
}

output "blob_container_name" {
  value = azurerm_storage_container.blob_container.name
}

output "blob_name" {
  value = azurerm_storage_blob.example_blob.name
}

output "storage_account_id" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.blob_storage.id
}

output "storage_url" {
  description = "The ID of the storage account"
  value       = azurerm_storage_account.blob_storage.primary_blob_endpoint
}

