resource "random_string" "pg_server" {
  length  = 10
  special = false
  upper   = false
  lower   = true
  numeric = true
}

resource "azurerm_postgresql_server" "postgresql" {
  name                = "pgserver-${random_string.pg_server.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "GP_Gen5_2" # General Purpose avec 2 vCores
  storage_mb          = 5120  # 5 Go, ajustez en fonction de vos besoins
  version             = "11"
  administrator_login = var.administrator_login
  administrator_login_password = var.administrator_login_password

  ssl_enforcement_enabled = true

  tags = {
    environment = "production"
  }
}

resource "azurerm_postgresql_database" "example_db" {
  name                = "mydatabase"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

# Zone DNS privée pour PostgreSQL
resource "azurerm_private_dns_zone" "postgresql_dns_zone" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

# Association entre la zone DNS privée et le VNet
resource "azurerm_private_dns_zone_virtual_network_link" "postgresql_dns_zone_link" {
  name                  = "postgresql-dns-link"
  private_dns_zone_name = azurerm_private_dns_zone.postgresql_dns_zone.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.vnet_id
}

# Création d'un point de terminaison privé pour PostgreSQL dans le sous-réseau
resource "azurerm_private_endpoint" "postgresql_private_endpoint" {
  name                = "postgresql-private-endpoint"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.vnet_subnet_id  # Utilisation du subnet configuré pour la DB

  private_service_connection {
    name                           = "postgresql-connection"
    private_connection_resource_id = azurerm_postgresql_server.postgresql.id
    subresource_names              = ["postgresqlServer"]  # Connexion privée pour PostgreSQL
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                = "dns"
    private_dns_zone_ids = [azurerm_private_dns_zone.postgresql_dns_zone.id]
  }
}
