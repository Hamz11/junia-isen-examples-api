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
  default     = "projet-cloud3"  # Nom de ton groupe de ressources
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
variable "administrator_login" {
  description = "log de l'administrateur"
  type        = string
}

variable "administrator_login_password" {
  description = "Mot de passe de l'administrateur"
  type        = string
}


variable "service_plan_name" {
  description = "Name of service plan"
  type        = string
  default     = "my_service_plan"
}

variable "docker_registry_password" {
  description = "Docker password"
  type        = string
}

variable "docker_image" {
  description = "Image"
  type        = string
  default     = "ghcr.io/lskrzypc/cloud_computing_24:latest"
}

variable "docker_registry_username" {
  description = "Docker username"
  type        = string
  default     = "Lskrzypc"
}

variable "docker_registry_url" {
  description = "Docker url"
  type        = string
  default     = "https://ghcr.io"
}

variable "app_service_name" {
  description = "App service name"
  type        = string
  default     = "cloudcomputing2024api"

}

