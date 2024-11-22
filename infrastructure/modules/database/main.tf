# Génération d'un nom aléatoire pour le serveur PostgreSQL
# Cela garantit un nom unique, ce qui est nécessaire pour les serveurs PostgreSQL sur Azure.
resource "random_string" "pg_server" {
  length  = 10    # Longueur de 10 caractères pour maintenir un équilibre entre lisibilité et unicité.
  special = false # Pas de caractères spéciaux pour respecter les contraintes de nommage Azure.
  upper   = false # Utilisation uniquement de minuscules pour respecter les contraintes de PostgreSQL.
  lower   = true  # Les lettres seront en minuscules.
  numeric = true  # Inclusion de chiffres pour accroître l'unicité.
}

# Création d'un serveur PostgreSQL sur Azure
# Ce serveur héberge la base de données avec des configurations adaptées aux besoins d'une application production.
resource "azurerm_postgresql_server" "postgresql" {
  name                = "pgserver-${random_string.pg_server.result}" # Nom unique généré dynamiquement.
  resource_group_name = var.resource_group_name                      # Appartient au groupe de ressources spécifié.
  location            = var.location                                 # Localisation dans la région spécifiée.
  sku_name            = "GP_Gen5_2"                                  # SKU avec 2 vCores pour un usage équilibré.
  storage_mb          = 5120                                         # Capacité de stockage de 5 Go, ajustable selon les besoins.
  version             = "11"                                         # Version de PostgreSQL choisie pour sa stabilité.
  administrator_login = var.administrator_login                      # Identifiant administrateur configurable.
  administrator_login_password = var.administrator_login_password    # Mot de passe administrateur sécurisé.

  ssl_enforcement_enabled = true # Activation de SSL pour sécuriser les connexions.

  tags = {
    environment = "production"   # Balise pour identifier l'environnement.
  }
}

# Création d'une base de données PostgreSQL
# La base de données héberge les données applicatives avec une configuration UTF-8.
resource "azurerm_postgresql_database" "example_db" {
  name                = "mydatabase"                                  # Nom de la base de données.
  resource_group_name = var.resource_group_name                       # Appartient au groupe de ressources spécifié.
  server_name         = azurerm_postgresql_server.postgresql.name     # Lien avec le serveur PostgreSQL.
  charset             = "UTF8"                                        # Jeu de caractères UTF-8 pour une compatibilité large.
  collation           = "English_United States.1252"                  # Collation adaptée à l'anglais (États-Unis).
}

# Création d'une zone DNS privée pour PostgreSQL
# La zone DNS permet de résoudre les noms de domaine privés pour PostgreSQL.
resource "azurerm_private_dns_zone" "postgresql_dns_zone" {
  name                = "privatelink.postgres.database.azure.com" # Zone DNS privée pour les connexions PostgreSQL.
  resource_group_name = var.resource_group_name                   # Associée au groupe de ressources.
}

# Association de la zone DNS privée avec le réseau virtuel
# Permet aux ressources dans le VNet de résoudre les noms DNS privés.
resource "azurerm_private_dns_zone_virtual_network_link" "postgresql_dns_zone_link" {
  name                  = "postgresql-dns-link"                             # Nom descriptif de l'association.
  private_dns_zone_name = azurerm_private_dns_zone.postgresql_dns_zone.name # Lien avec la zone DNS privée.
  resource_group_name   = var.resource_group_name                           # Groupe de ressources associé.
  virtual_network_id    = var.vnet_id                                       # ID du VNet cible pour la résolution DNS.
}

# Création d'un point de terminaison privé pour PostgreSQL
# Ce point de terminaison sécurise l'accès au serveur PostgreSQL via le réseau privé.
resource "azurerm_private_endpoint" "postgresql_private_endpoint" {
  name                = "postgresql-private-endpoint"                # Nom descriptif du point de terminaison.
  resource_group_name = var.resource_group_name                      # Appartient au groupe de ressources spécifié.
  location            = var.location                                 # Localisé dans la région spécifiée.
  subnet_id           = var.vnet_subnet_id                           # ID du sous-réseau pour l'intégration privée.

  # Connexion privée au serveur PostgreSQL
  private_service_connection {
    name                           = "postgresql-connection"                 # Nom de la connexion privée.
    private_connection_resource_id = azurerm_postgresql_server.postgresql.id # Lien avec le serveur PostgreSQL.
    subresource_names              = ["postgresqlServer"]                    # Sous-ressource ciblée pour PostgreSQL.
    is_manual_connection           = false                                   # Connexion automatique gérée par Azure.
  }

  # Ajout de la zone DNS privée à la connexion privée
  private_dns_zone_group {
    name                = "dns"                                              # Nom du groupe DNS.
    private_dns_zone_ids = [azurerm_private_dns_zone.postgresql_dns_zone.id] # Lien avec la zone DNS privée.
  }
}
