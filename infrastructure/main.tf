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

# Appel du module vnet

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

# A décommenter pour ajouter le blob storage au subnet 

 module "blob_storage" {
   source                 = "./modules/blob_storage"
   resource_group_name    = var.resource_group_name
   location               = var.location
   vnet_subnet_id         = module.vnet.blob_storage_subnet_id  # Utilisation de la sortie pour le subnet Blob Storage
 }


module "database" {
  source               = "./modules/database"
  resource_group_name  = var.resource_group_name
  location             = var.location
  vnet_subnet_id       = module.vnet.database_subnet_id  # L'ID du sous-réseau pour PostgreSQL
  sku_name             = var.postgresql_sku_name        # Définit le SKU (ex: "B_Gen5_1")
  storage_tier         = var.postgresql_storage_tier    # Définit le niveau de stockage (ex: "Standard")
  vnet_id             = module.vnet.vnet_id
  administrator_login = var.administrator_login
  administrator_login_password = var.administrator_login_password
}
