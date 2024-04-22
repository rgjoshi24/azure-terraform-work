variable "business_unit" {
  description = "Deployment Business Unit"
  type        = string
  default     = "cft"
}

variable "environment" {
  description = "Deployment Environment"
  type        = string
  default     = "test"
}

variable "resource_group" {
  description = "The name of your Azure Resource Group."
  type        = string
  default     = "rj-tf-rg"
}

variable "location" {
  description = "The region where the virtual network is created."
  type        = string
  default     = "southcentralus"
}

