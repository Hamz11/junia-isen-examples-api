variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}



variable "location" {
  description = "Emplacement global pour l'infrastructure"
  type        = string
  default     = "France Central"  # Tu peux aussi choisir "France South"
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
  default     = "projet-cloud"  # Nom de ton groupe de ressources
}

# Ajouter d'autres variables globales selon les besoins de ton infrastructure


variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default ="Vnet_Projet"
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = string
  default     = "10.0.0.0/16"  # Adresse de base pour le VNet

}

variable "app_service_subnet_prefix" {
  description = "Address prefix for the App Service subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "database_subnet_prefix" {
  description = "Address prefix for the Database subnet"
  type        = string
  default     = "10.0.2.0/24"

}

variable "blob_storage_subnet_prefix" {
  description = "Address prefix for the Blob Storage subnet"
  type        = string
  default     = "10.0.3.0/24"

}



variable "postgresql_sku_name" {
  description = "The SKU name for the PostgreSQL database"
  type        = string
  default     = "B_Gen5_1"
}

variable "postgresql_storage_tier" {
  description = "The storage tier for PostgreSQL"
  type        = string
  default     = "Standard"
}
