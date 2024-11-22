resource "random_string" "app_server" {
  length  = 10
  special = false
  upper   = false
  lower   = true
  numeric = true
}

resource "azurerm_app_service_plan" "app_plan" {
  name                = "appserver-${random_string.app_server.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux" # Modifiez selon votre besoin ("Windows" si nécessaire)
  reserved = true 

  sku {
    tier = "Basic" # Peut être Free ou Shared si vous voulez limiter les coûts
    size = "B1"    # Changez selon vos besoins
  }
}

resource "azurerm_app_service" "app_service" {
  name                = "appserviceplan-${random_string.app_server.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_plan.id

  site_config {
    linux_fx_version = "DOTNETCORE|6.0" # Exemple pour .NET, changez selon votre stack (exemple : "PYTHON|3.9")
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.application_insights_key
    "WEBSITE_RUN_FROM_PACKAGE"       = "1"
  }

    connection_string {
        name  = "DefaultConnection"
        type  = "PostgreSQL"
        value = var.connection_string
    }
}

resource "azurerm_private_endpoint" "app_service_private_endpoint" {
  name                = "${var.app_service_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.vnet_subnet_id  # ID du subnet de l'App Service

  private_service_connection {
    name                           = "${var.app_service_name}-private-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_app_service.app_service.id
    subresource_names              = ["sites"]  # Sous-ressource spécifique à un App Service
  }
}
