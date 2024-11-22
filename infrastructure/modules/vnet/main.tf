# Création d'un réseau virtuel (VNet) pour le projet
# Le VNet fournit un réseau isolé pour les ressources Azure, avec un espace d'adressage spécifié.
resource "azurerm_virtual_network" "Vnet_projet_cloud" {
  name                = var.vnet_name             # Nom du VNet défini via une variable.
  address_space       = [var.vnet_address_space]  # Plage d'adresses IP pour le VNet (exemple : "10.0.0.0/16").
  location            = var.location              # Région où le VNet sera créé.
  resource_group_name = var.resource_group_name   # Groupe de ressources associé au VNet.
}

# Création d'un sous-réseau pour App Service
# Ce sous-réseau est dédié aux ressources Azure App Service, permettant une meilleure isolation et sécurité.
resource "azurerm_subnet" "app_service_subnet" {
  name                 = "app-service-subnet"                           # Nom du sous-réseau.
  resource_group_name  = var.resource_group_name                        # Groupe de ressources associé.
  virtual_network_name = azurerm_virtual_network.Vnet_projet_cloud.name # VNet parent du sous-réseau.
  address_prefixes     = [var.app_service_subnet_prefix]                # Plage d'adresses IP pour ce sous-réseau.
}

# Création d'un sous-réseau pour la base de données
# Ce sous-réseau isole les bases de données des autres ressources pour des raisons de sécurité et de gestion.
resource "azurerm_subnet" "database_subnet" {
  name                 = "database-subnet"                              # Nom du sous-réseau.
  resource_group_name  = var.resource_group_name                        # Groupe de ressources associé.
  virtual_network_name = azurerm_virtual_network.Vnet_projet_cloud.name # VNet parent du sous-réseau.
  address_prefixes     = [var.database_subnet_prefix]                   # Plage d'adresses IP pour ce sous-réseau.
}

# Création d'un sous-réseau pour Blob Storage
# Ce sous-réseau est dédié aux comptes de stockage Blob, permettant des connexions privées et sécurisées.
resource "azurerm_subnet" "blob_storage_subnet" {
  name                 = "blob-storage-subnet"                          # Nom du sous-réseau.
  resource_group_name  = var.resource_group_name                        # Groupe de ressources associé.
  virtual_network_name = azurerm_virtual_network.Vnet_projet_cloud.name # VNet parent du sous-réseau.
  address_prefixes     = [var.blob_storage_subnet_prefix]               # Plage d'adresses IP pour ce sous-réseau.
}
