# Création d'un plan de service Azure pour héberger l'application
resource "azurerm_service_plan" "api_plan" {
  name                = var.service_plan_name                 # Nom du plan de service, défini par une variable
  resource_group_name = var.resource_group_name               # Groupe de ressources dans lequel le plan sera créé
  location            = var.physical_location                 # Localisation physique du plan (région Azure)
  os_type             = "Linux"                               # Type de système d'exploitation du plan
  sku_name            = "B1"                                  # Niveau tarifaire du plan (B1 = Basic)
}

# Création de l'application web (App Service)
resource "azurerm_linux_web_app" "app_service" {
  name                          = var.app_service_name         # Nom de l'App Service, défini par une variable
  resource_group_name           = var.resource_group_name      # Groupe de ressources dans lequel l'application est déployée
  location                      = var.physical_location        # Localisation physique de l'application
  service_plan_id               = azurerm_service_plan.api_plan.id # Référence au plan de service créé précédemment
  public_network_access_enabled = true                         # Activation de l'accès réseau public
  virtual_network_subnet_id     = var.app_subnet_id            # ID du sous-réseau de la VNet auquel l'application est attachée

  # Configuration du site, incluant les paramètres du conteneur Docker
  site_config {
    application_stack {
      docker_registry_url      = var.docker_registry_url       # URL du registre Docker
      docker_image_name        = var.docker_image             # Nom de l'image Docker
      docker_registry_password = var.docker_registry_password # Mot de passe du registre Docker
      docker_registry_username = var.docker_registry_username # Nom d'utilisateur pour le registre Docker
    }
  }

  # Variables d'environnement pour l'application (base de données et stockage)
  app_settings = {
    DATABASE_HOST     = var.database_host                     # Hôte de la base de données
    DATABASE_PORT     = var.database_port                     # Port de connexion à la base de données
    DATABASE_NAME     = var.database_name                     # Nom de la base de données
    DATABASE_USER     = var.database_user                     # Nom d'utilisateur pour la base de données
    DATABASE_PASSWORD = var.database_password                 # Mot de passe pour la base de données
    STORAGE_ACCOUNT_URL = var.storage_url                     # URL du compte de stockage
  }

  # Activation de l'identité managée pour l'App Service
  identity {
    type = "SystemAssigned"                                   # Identité gérée automatiquement par Azure
  }
}

# Assignation du rôle nécessaire pour permettre à l'application d'accéder au stockage
resource "azurerm_role_assignment" "app_service_storage_access" {
  principal_id         = azurerm_linux_web_app.app_service.identity[0].principal_id # ID de l'identité gérée de l'App Service
  role_definition_name = "Storage Blob Data Contributor"      # Rôle accordé (contributeur pour le stockage de blobs)
  scope                = var.storage_account_id              # Portée : le compte de stockage concerné
}
