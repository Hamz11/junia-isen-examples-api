output "vnet_id" {
  description = "L'ID du réseau virtuel (Virtual Network)"
  value       = azurerm_virtual_network.Vnet_projet_cloud.id
}

output "app_service_subnet_id" {
  description = "L'ID du sous-réseau pour App Service"
  value       = azurerm_subnet.app_service_subnet.id
}

output "database_subnet_id" {
  description = "L'ID du sous-réseau pour la base de données"
  value       = azurerm_subnet.database_subnet.id
}

output "blob_storage_subnet_id" {
  description = "L'ID du sous-réseau pour le stockage Blob"
  value       = azurerm_subnet.blob_storage_subnet.id
}
