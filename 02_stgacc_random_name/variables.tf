variable "resource_group" {
  description = "The name of your Azure Resource Group."
  default     = "rj-tf-rg"
}

variable "location" {
  description = "The region where the virtual network is created."
  default     = "southcentralus"
}

variable "storage_account_name" {
  description = "The name of your Azure Storage Account."
  default     = "rjautostg"
}