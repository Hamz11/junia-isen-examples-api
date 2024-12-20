output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "location" {
  description = "Emplacement du groupe de ressources"
  value = module.resource_group.location
}


output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = module.vnet.vnet_id
}

output "app_service_subnet_id" {
  description = "The ID of the App Service Subnet"
  value       = module.vnet.app_service_subnet_id
}

output "database_subnet_id" {
  description = "The ID of the Database Subnet"
  value       = module.vnet.database_subnet_id
}

output "blob_storage_subnet_id" {
  description = "The ID of the Blob Storage Subnet"
  value       = module.vnet.blob_storage_subnet_id
}



output "blob_storage_account_name" {
  value = module.blob_storage.storage_account_name
}

output "blob_container_name" {
  value = module.blob_storage.blob_container_name
}

output "blob_name" {
  value = module.blob_storage.blob_name
}

output "database_user" {
  value = "${var.administrator_login}@${module.database.name}"
}

output "database_host" {
  description = "lien de l'app service pour acceder aux routes de l'API"
  value = module.database.postgresql_host
}