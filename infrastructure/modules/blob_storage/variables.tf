variable "resource_group_name" {
  description = "The name of the resource group in which the database will be created."
  type        = string
}

variable "location" {
  description = "The location for the storage account"
  type        = string
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet where the Blob Storage will be connected"
  type        = string
}

