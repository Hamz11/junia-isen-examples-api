variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "app_service_subnet_prefix" {
  description = "Address prefix for the App Service subnet"
  type        = string
}

variable "database_subnet_prefix" {
  description = "Address prefix for the Database subnet"
  type        = string
}

variable "blob_storage_subnet_prefix" {
  description = "Address prefix for the Blob Storage subnet"
  type        = string
}
