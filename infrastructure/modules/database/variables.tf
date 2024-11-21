variable "resource_group_name" {
  description = "The name of the resource group where the database will be created"
  type        = string
}

variable "location" {
  description = "The location for the database"
  type        = string
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet where the PostgreSQL database will be connected"
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the database"
  type        = string
  default     = "GP_Gen5_2"  # Utilisez une offre de base, compatible avec Azure for Students
}

variable "storage_tier" {
  description = "The storage tier for the database"
  type        = string
  default     = "Standard"  # Assurez-vous que c'est compatible avec votre abonnement
}

variable "vnet_id" {
  description = "ID du réseau virtuel auquel lier la zone DNS privée"
  type        = string
}
