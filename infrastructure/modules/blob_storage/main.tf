# Génération d'un nom aléatoire pour le compte de stockage
# Utiliser un nom unique évite les conflits lors de la création des comptes de stockage Azure, 
# car les noms doivent être globaux et respecter certaines règles.
resource "random_string" "my_random_storage_name" {
  length  = 24    # Longueur du nom généré
  special = false # Pas de caractères spéciaux pour respecter les contraintes Azure
  upper   = false # Nom en minuscules, car Azure exige des noms en minuscules
}

# Création d'un compte de stockage Azure
# Ce compte est configuré pour un usage standard avec réplication locale (LRS), 
# ce qui est adapté aux besoins classiques de stockage Blob.
resource "azurerm_storage_account" "blob_storage" {
  name                     = random_string.my_random_storage_name.result # Nom généré dynamiquement
  resource_group_name      = var.resource_group_name                     # Appartient au groupe de ressources spécifié
  location                 = var.location                                # Localisé dans la région spécifiée
  account_tier             = "Standard"                                  # Niveau de performance standard pour réduire les coûts
  account_replication_type = "LRS"                                       # Réplication locale pour une haute disponibilité dans la région
}

# Création d'un conteneur Blob dans le compte de stockage
# Le conteneur est l'endroit où les blobs (fichiers) seront stockés.
resource "azurerm_storage_container" "blob_container" {
  name                  = random_string.my_random_storage_name.result    # Nom du conteneur basé sur le compte
  storage_account_id    = azurerm_storage_account.blob_storage.id        # Associe le conteneur au compte de stockage
  container_access_type = "private"                                      # Accès privé pour des raisons de sécurité
}

# Téléchargement d'un exemple de blob (fichier) dans le conteneur
# Ce bloc simule le stockage d'un fichier spécifique (par exemple, un fichier ZIP).
resource "azurerm_storage_blob" "example_blob" {
  name                   = "{random_string.my_random_storage_name.result}.zip" # Nom du blob (fichier) basé sur le compte
  storage_account_name   = azurerm_storage_account.blob_storage.name           # Compte de stockage cible
  storage_container_name = azurerm_storage_container.blob_container.name       # Conteneur cible
  type                   = "Block"                                             # Type de blob (Block est le plus courant pour les fichiers)
}

# Configuration d'un Private Endpoint pour sécuriser l'accès au stockage Blob
# Le Private Endpoint connecte le stockage Blob au réseau virtuel (VNet),
# garantissant que le trafic ne passe pas par l'Internet public.
resource "azurerm_private_endpoint" "blob_private_endpoint" {
  name                = "blob-private-endpoint"                       # Nom descriptif pour le Private Endpoint
  location            = azurerm_storage_account.blob_storage.location # Localisation dans la même région que le compte de stockage
  resource_group_name = var.resource_group_name                       # Appartient au groupe de ressources spécifié
  subnet_id           = var.vnet_subnet_id                            # ID du sous-réseau où le Private Endpoint est créé

  # Détails de la connexion privée au stockage Blob
  private_service_connection {
    name                           = "blob-storage-connection"               # Nom de la connexion privée
    private_connection_resource_id = azurerm_storage_account.blob_storage.id # ID de la ressource cible (compte de stockage)
    subresource_names              = ["blob"]                                # Service spécifique (Blob) ciblé par le Private Endpoint
    is_manual_connection           = false                                   # La connexion est gérée automatiquement par Azure
  }
}