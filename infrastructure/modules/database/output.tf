output "postgresql_server_id" {
  description = "The ID of the PostgreSQL Server"
  value       = azurerm_postgresql_server.postgresql.id
}

output "postgresql_server_fqdn" {
  description = "The Fully Qualified Domain Name of the PostgreSQL Server"
  value       = azurerm_postgresql_server.postgresql.fqdn
}

output "postgresql_private_endpoint_id" {
  description = "The ID of the PostgreSQL Private Endpoint"
  value       = azurerm_private_endpoint.postgresql_private_endpoint.id
}


