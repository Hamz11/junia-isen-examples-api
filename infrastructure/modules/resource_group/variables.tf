variable "location" {
  description = "Emplacement où le groupe de ressources sera créé"
  type        = string
  default     = "France Central"  
}

variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
  default     = "projet-cloud-rg"  # Nom par défaut du groupe de ressources
}
