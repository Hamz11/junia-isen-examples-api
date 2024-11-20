resource "azurerm_virtual_network" "Vnet_projet_cloud" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "app_service_subnet" {
  name                 = "app-service-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet_projet_cloud.name
  address_prefixes     = [var.app_service_subnet_prefix]
}

resource "azurerm_subnet" "database_subnet" {
  name                 = "database-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet_projet_cloud.name
  address_prefixes     = [var.database_subnet_prefix]
}

resource "azurerm_subnet" "blob_storage_subnet" {
  name                 = "blob-storage-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.Vnet_projet_cloud.name
  address_prefixes     = [var.blob_storage_subnet_prefix]
}
