output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.Vnet_projet_cloud.id
}

output "app_service_subnet_id" {
  description = "The ID of the App Service Subnet"
  value       = azurerm_subnet.app_service_subnet.id
}

output "database_subnet_id" {
  description = "The ID of the Database Subnet"
  value       = azurerm_subnet.database_subnet.id
}

output "blob_storage_subnet_id" {
  description = "The ID of the Blob Storage Subnet"
  value       = azurerm_subnet.blob_storage_subnet.id
}
