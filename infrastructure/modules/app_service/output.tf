output "app_service_fqdn" {
  value = azurerm_linux_web_app.app_service.default_hostname
}