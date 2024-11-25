# Génération d'une chaîne aléatoire pour le nom du serveur PostgreSQL
resource "random_string" "pg_server" {
  length  = 10       # Longueur de la chaîne (10 caractères)
  special = false    # Pas de caractères spéciaux
  upper   = false    # Pas de majuscules
  lower   = true     # Utilisation de lettres minuscules
  numeric = true     # Inclut des chiffres
}

# Création d'un serveur PostgreSQL Azure
resource "azurerm_postgresql_server" "postgresql" {
  name                = "pgserver-${random_string.pg_server.result}" # Nom unique grâce à la chaîne aléatoire
  resource_group_name = var.resource_group_name                      # Groupe de ressources Azure
  location            = var.location                                 # Localisation dans une région Azure
  sku_name            = "GP_Gen5_2"                                 # Type de SKU : General Purpose, 2 vCores
  storage_mb          = 5120                                        # Taille de stockage allouée (5 Go)
  version             = "11"                                       # Version de PostgreSQL
  administrator_login = var.administrator_login                    # Nom d'utilisateur administrateur
  administrator_login_password = var.administrator_login_password  # Mot de passe administrateur

  ssl_enforcement_enabled = true                                   # Enforce SSL pour les connexions

  tags = {
    environment = "production"                                     # Tag pour identifier l'environnement
  }
}

# Création d'une base de données PostgreSQL dans le serveur
resource "azurerm_postgresql_database" "example_db" {
  name                = "mydatabase"                              # Nom de la base de données
  resource_group_name = var.resource_group_name                   # Groupe de ressources Azure
  server_name         = azurerm_postgresql_server.postgresql.name # Nom du serveur associé
  charset             = "UTF8"                                   # Jeu de caractères
  collation           = "English_United States.1252"             # Collation pour le tri et les comparaisons
}

# Création d'une zone DNS privée pour le serveur PostgreSQL
resource "azurerm_private_dns_zone" "postgresql_dns_zone" {
  name                = "privatelink.postgres.database.azure.com" # Zone DNS pour les connexions privées
  resource_group_name = var.resource_group_name                  # Groupe de ressources Azure
}

# Association de la zone DNS privée au réseau virtuel
resource "azurerm_private_dns_zone_virtual_network_link" "postgresql_dns_zone_link" {
  name                  = "postgresql-dns-link"                 # Nom du lien entre la zone DNS et le VNet
  private_dns_zone_name = azurerm_private_dns_zone.postgresql_dns_zone.name # Nom de la zone DNS privée
  resource_group_name   = var.resource_group_name               # Groupe de ressources Azure
  virtual_network_id    = var.vnet_id                           # ID du réseau virtuel
}

# Création d'un point de terminaison privé pour sécuriser les connexions à PostgreSQL
resource "azurerm_private_endpoint" "postgresql_private_endpoint" {
  name                = "postgresql-private-endpoint"           # Nom du point de terminaison privé
  resource_group_name = var.resource_group_name                # Groupe de ressources Azure
  location            = var.location                           # Localisation (même que le serveur PostgreSQL)
  subnet_id           = var.vnet_subnet_id                     # Sous-réseau du VNet pour le point de terminaison

  # Configuration de la connexion privée au serveur PostgreSQL
  private_service_connection {
    name                           = "postgresql-connection"    # Nom de la connexion privée
    private_connection_resource_id = azurerm_postgresql_server.postgresql.id # Référence au serveur PostgreSQL
    subresource_names              = ["postgresqlServer"]       # Type de connexion privée pour PostgreSQL
    is_manual_connection           = false                     # Connexion gérée automatiquement
  }

  # Association du point de terminaison à la zone DNS privée
  private_dns_zone_group {
    name                = "dns"                                # Nom du groupe DNS privé
    private_dns_zone_ids = [azurerm_private_dns_zone.postgresql_dns_zone.id] # ID de la zone DNS privée
  }
}
