variable "resource_group_name" {
  description = "Le nom du groupe de ressources où la base de données sera créée"
  type        = string
}

variable "location" {
  description = "La région où la base de données sera déployée"
  type        = string
}

variable "vnet_subnet_id" {
  description = "L'ID du sous-réseau où la base de données PostgreSQL sera connectée"
  type        = string
}

variable "sku_name" {
  description = "Le nom de l'offre (SKU) pour la base de données"
  type        = string
  default     = "GP_Gen5_2"  # Utilisez une offre de base, compatible avec Azure for Students
}

variable "storage_tier" {
  description = "Le niveau de stockage pour la base de données"
  type        = string
  default     = "Standard"  # Assurez-vous que c'est compatible avec votre abonnement
}

variable "vnet_id" {
  description = "L'ID du réseau virtuel auquel lier la zone DNS privée"
  type        = string
}

variable "administrator_login" {
  description = "Le login de l'administrateur"
  type        = string
}

variable "administrator_login_password" {
  description = "Le mot de passe de l'administrateur"
  type        = string
}
