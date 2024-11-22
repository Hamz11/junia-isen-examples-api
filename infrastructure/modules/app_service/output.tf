output "app_service_default_hostname" {
  value       = azurerm_app_service.app_service.default_site_hostname
  description = "The default hostname of the App Service"
}

output "app_service_plan_id" {
  value       = azurerm_app_service_plan.app_plan.id
  description = "The ID of the App Service Plan"
}