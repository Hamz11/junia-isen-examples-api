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

