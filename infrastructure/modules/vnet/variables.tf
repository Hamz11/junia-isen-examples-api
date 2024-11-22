variable "vnet_name" {
  description = "Nom du réseau virtuel (Virtual Network)"
  type        = string
}

variable "vnet_address_space" {
  description = "Espace d'adressage pour le réseau virtuel"
  type        = string
}

variable "location" {
  description = "Région où les ressources seront créées"
  type        = string
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
}

variable "app_service_subnet_prefix" {
  description = "Préfixe d'adresse pour le sous-réseau App Service"
  type        = string
}

variable "database_subnet_prefix" {
  description = "Préfixe d'adresse pour le sous-réseau de la base de données"
  type        = string
}

variable "blob_storage_subnet_prefix" {
  description = "Préfixe d'adresse pour le sous-réseau du stockage Blob"
  type        = string
}
