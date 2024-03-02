variable "resource_group_prod" {
  description = "The name of your Azure Resource Group."
  default     = "rj-tf-rg-prod"
}

variable "resource_group_dr" {
  description = "The name of your Azure Resource Group."
  default     = "rj-tf-rg-dr"
}

variable "prodlocation" {
  description = "The region where the virtual network is created."
  default     = "southcentralus"
}

variable "drlocation" {
  description = "The region where the virtual network is created."
  default     = "centralus"
}

variable "storage_account_name_prod" {
  description = "The name of your Azure Storage Account."
  default     = "rjautostgprd"
}

variable "storage_account_name_dr" {
  description = "The name of your Azure Storage Account."
  default     = "rjautostgdr"
}