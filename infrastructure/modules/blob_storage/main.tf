resource "random_string" "my_random_storage_name" {
  length = 24
  special = false
  upper = false 
}

resource "azurerm_storage_account" "blob_storage" {
  name                     = random_string.my_random_storage_name.result
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "blob_container" {
  name                  = random_string.my_random_storage_name.result
  storage_account_id    = azurerm_storage_account.blob_storage.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "example_blob" {
  name                   = "{random_string.my_random_storage_name.result}.zip"
  storage_account_name   = azurerm_storage_account.blob_storage.name
  storage_container_name = azurerm_storage_container.blob_container.name
  type                   = "Block"
}

# Création d'un Private Endpoint pour connecter Blob Storage au subnet du VNet
resource "azurerm_private_endpoint" "blob_private_endpoint" {
  name                = "blob-private-endpoint"
  location            = azurerm_storage_account.blob_storage.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.vnet_subnet_id  # Utilisation de la variable qui contient l'ID du subnet

  private_service_connection {
    name                           = "blob-storage-connection"
    private_connection_resource_id = azurerm_storage_account.blob_storage.id
    subresource_names              = ["blob"]
    is_manual_connection          = false  # Connexion gérée automatiquement

  }
}