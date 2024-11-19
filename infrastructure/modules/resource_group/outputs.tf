output "resource_group_name" {
  description = "Nom du groupe de ressources créé"
  value = azurerm_resource_group.projet_cloud.name
}

output "location" {
  description = "Emplacement du groupe de ressources et des modules"
  value       = azurerm_resource_group.projet_cloud.location
}
