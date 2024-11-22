variable "resource_group_name" {
  description = "Le nom du groupe de ressources dans lequel la base de données sera créée."
  type        = string
}

variable "location" {
  description = "La région où le compte de stockage sera déployé."
  type        = string
}

variable "vnet_subnet_id" {
  description = "L'ID du sous-réseau où le stockage Blob sera connecté."
  type        = string
}
