output "postgresql_server_id" {
  description = "L'ID du serveur PostgreSQL"
  value       = azurerm_postgresql_server.postgresql.id
}

output "postgresql_server_fqdn" {
  description = "Le nom de domaine complet (FQDN) du serveur PostgreSQL"
  value       = azurerm_postgresql_server.postgresql.fqdn
}

output "postgresql_private_endpoint_id" {
  description = "L'ID du point de terminaison privé pour PostgreSQL"
  value       = azurerm_private_endpoint.postgresql_private_endpoint.id
}
