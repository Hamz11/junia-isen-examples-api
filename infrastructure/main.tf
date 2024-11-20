provider "azurerm" {
  features {}

  # Paramètres d'authentification
  subscription_id = var.subscription_id
}


# Appel du module resource_group
module "resource_group" {
  source              = "./modules/resource_group"  # Chemin du module créé
  resource_group_name = var.resource_group_name    # Nom du groupe de ressources
  location            = var.location                # Région où le groupe de ressources sera créé
}

# Appel du module

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_subnet_prefix = var.app_service_subnet_prefix
  database_subnet_prefix    = var.database_subnet_prefix
  blob_storage_subnet_prefix = var.blob_storage_subnet_prefix
}
