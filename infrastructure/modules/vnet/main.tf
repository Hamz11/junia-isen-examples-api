# Création d'un réseau virtuel Azure
resource "azurerm_virtual_network" "Vnet_projet_cloud" {
  name                = var.vnet_name                  # Nom du réseau virtuel, défini par une variable
  address_space       = [var.vnet_address_space]       # Espace d'adressage IP pour le réseau (ex. : "10.0.0.0/16")
  location            = var.location                   # Localisation dans une région Azure
  resource_group_name = var.resource_group_name        # Groupe de ressources associé
}

# Création d'un sous-réseau dédié aux App Services
resource "azurerm_subnet" "app_service_subnet" {
  name                 = "app-service-subnet"          # Nom du sous-réseau
  resource_group_name  = var.resource_group_name       # Groupe de ressources associé
  virtual_network_name = azurerm_virtual_network.Vnet_projet_cloud.name # Nom du réseau virtuel parent
  address_prefixes     = [var.app_service_subnet_prefix] # Plage d'adresses IP attribuées à ce sous-réseau

  # Délégation pour autoriser l'usage spécifique aux App Services
  delegation {
    name = "app-service-delegation"                   # Nom de la délégation
    service_delegation {
      name    = "Microsoft.Web/serverFarms"           # Service spécifique autorisé (App Services)
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"] # Action autorisée
    }
  }
}

# Création d'un sous-réseau dédié à la base de données
resource "azurerm_subnet" "database_subnet" {
  name                 = "database-subnet"            # Nom du sous-réseau
  resource_group_name  = var.resource_group_name      # Groupe de ressources associé
  virtual_network_name = azurerm_virtual_network.Vnet_projet_cloud.name # Nom du réseau virtuel parent
  address_prefixes     = [var.database_subnet_prefix] # Plage d'adresses IP pour ce sous-réseau
}

# Création d'un sous-réseau dédié au stockage Blob
resource "azurerm_subnet" "blob_storage_subnet" {
  name                 = "blob-storage-subnet"        # Nom du sous-réseau
  resource_group_name  = var.resource_group_name      # Groupe de ressources associé
  virtual_network_name = azurerm_virtual_network.Vnet_projet_cloud.name # Nom du réseau virtuel parent
  address_prefixes     = [var.blob_storage_subnet_prefix] # Plage d'adresses IP pour ce sous-réseau
}
