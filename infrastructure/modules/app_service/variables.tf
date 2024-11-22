variable "location" {
  description = "The location where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "app_service_name" {
  description = "The name of the App Service"
  type        = string
}

variable "application_insights_key" {
  description = "Instrumentation key for Application Insights"
  type        = string
  default     = null
}

variable "postgresql_connection_string" {
  description = "The connection string for PostgreSQL"
  type        = string
  default     = null
}

variable "connection_string" {
  description = "La chaîne de connexion utilisée par l'App Service pour se connecter à la base de données PostgreSQL"
  type        = string
}

variable "vnet_subnet_id" {
  description = "The ID of the subnet where the PostgreSQL database will be connected"
  type        = string
}