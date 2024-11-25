# Création d'un groupe de ressources Azure
resource "azurerm_resource_group" "projet_cloud" {
  name     = "projet-cloud" # Nom du groupe de ressources
  location = var.location   # Localisation définie par la variable 'location' (ex. : "East US")
}

