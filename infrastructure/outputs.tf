output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "location" {
  description = "Emplacement du groupe de ressources"
  value = module.resource_group.location
}
