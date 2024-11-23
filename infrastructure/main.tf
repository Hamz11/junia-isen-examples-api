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


module "app_service" {
  source              = "./modules/app_service"
  app_service_name    = var.app_service_name
  resource_group_name = module.resource_group.resource_group_name
  physical_location   = var.location
  # Docker vars using GHCR (GitHub Container Registry)
  docker_image             = var.docker_image
  docker_registry_username = var.docker_registry_username
  docker_registry_password = var.docker_registry_password
  docker_registry_url      = var.docker_registry_url
  # API subnet
  app_subnet_id     = module.vnet.app_service_subnet_id
  service_plan_name = var.service_plan_name
  vnet_subnet_id = module.vnet.app_service_subnet_id
  location            = var.location


  # Database environment variables
  database_host     = module.database.postgresql_host
  database_port     = module.database.postgresql_port
  database_name     = module.database.postgresql_db_name
  database_user     = var.administrator_login
  database_password = var.administrator_login_password 

  # Blob storage environment variables
  storage_url        = module.blob_storage.storage_url
  storage_account_id = module.blob_storage.storage_account_id
}
