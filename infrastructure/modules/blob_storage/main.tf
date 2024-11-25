# Génération d'une chaîne aléatoire pour le nom du compte de stockage (24 caractères, uniquement en minuscules)
resource "random_string" "my_random_storage_name" {
  length  = 24    # Longueur de la chaîne
  special = false # Pas de caractères spéciaux
  upper   = false # Pas de majuscules
}

# Création d'un compte de stockage Azure
resource "azurerm_storage_account" "blob_storage" {
  name                     = random_string.my_random_storage_name.result # Nom basé sur la chaîne aléatoire
  resource_group_name      = var.resource_group_name                     # Groupe de ressources Azure
  location                 = var.location                                # Localisation dans une région Azure
  account_tier             = "Standard"                                 # Niveau tarifaire du compte
  account_replication_type = "LRS"                                      # Réplication locale (Local Redundant Storage)
}

# Création d'un conteneur de stockage pour les blobs
resource "azurerm_storage_container" "blob_container" {
  name                  = "api"                                   # Nom du conteneur
  storage_account_id    = azurerm_storage_account.blob_storage.id # Référence au compte de stockage
  container_access_type = "private"                               # Accès privé au conteneur
}

# Ajout d'un fichier blob dans le conteneur
resource "azurerm_storage_blob" "example_blob" {
  name                   = "api.zip"                              # Nom du blob
  storage_account_name   = azurerm_storage_account.blob_storage.name # Nom du compte de stockage
  storage_container_name = azurerm_storage_container.blob_container.name # Nom du conteneur
  type                   = "Block"                                # Type de blob (Block)
}

# Création d'un point de terminaison privé pour connecter le compte de stockage à un sous-réseau VNet
resource "azurerm_private_endpoint" "blob_private_endpoint" {
  name                = "blob-private-endpoint"                   # Nom du Private Endpoint
  location            = azurerm_storage_account.blob_storage.location # Localisation (même que le compte de stockage)
  resource_group_name = var.resource_group_name                   # Groupe de ressources Azure
  subnet_id           = var.vnet_subnet_id                        # Sous-réseau où le point de terminaison est déployé

  # Configuration de la connexion privée
  private_service_connection {
    name                           = "blob-storage-connection"    # Nom de la connexion
    private_connection_resource_id = azurerm_storage_account.blob_storage.id # Référence au compte de stockage
    subresource_names              = ["blob"]                    # Type de service privé (blob storage)
    is_manual_connection           = false                       # Connexion automatique
  }
}

# Ajout d'un deuxième fichier blob dans le conteneur
resource "azurerm_storage_blob" "blob_storage" {
  name                   = "quotes.json"                             # Nom du blob
  source                 = "${path.module}/quotes.json"              # Chemin vers le fichier source dans le module Terraform
  storage_account_name   = azurerm_storage_account.blob_storage.name # Nom du compte de stockage
  storage_container_name = azurerm_storage_container.blob_container.name # Nom du conteneur
  type                   = "Block"                                   # Type de blob (Block)
}
