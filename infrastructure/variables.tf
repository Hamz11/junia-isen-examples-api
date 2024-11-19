variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "tenant" {
  description = "The Azure tenant ID"
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
  default     = "projet-cloud-rg"  # Nom de ton groupe de ressources
}

# Ajouter d'autres variables globales selon les besoins de ton infrastructure
