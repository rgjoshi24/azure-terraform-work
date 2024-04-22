# Virtual Network, Subnets and Subnet NSG's

## Virtual Network
variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
  default     = "vnet-tf"
}
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}


# Web Subnet Name
variable "webserver_subnet_name" {
  description = "Virtual Network Web Subnet Name"
  type        = string
  default     = "websubnet"
}
# Web Subnet Address Space
variable "webserver_subnet_address" {
  description = "Virtual Network Web Subnet Address Spaces"
  type        = list(string)
  default     = ["10.0.6.0/24"]
}

# Bastion Subnet Name
variable "bastion_subnet_name" {
  description = "Virtual Network Bastion Subnet Name"
  type        = string
  default     = "bastionsubnet"
}
# Bastion Subnet Address Space
variable "bastion_subnet_address" {
  description = "Virtual Network Bastion Subnet Address Spaces"
  type        = list(string)
  default     = ["10.0.15.0/24"]
}

# Azure Bastion Service Subnet Name
variable "bastion_service_subnet_name" {
  description = "Virtual Network Azure Bastion Service Subnet Name"
  type        = string
  default     = "AzureBastionSubnet"
}
# Azure Bastion Service Subnet Address Space
variable "bastion_service_subnet_address" {
  description = "Virtual Network Azure Bastion Service Subnet Address Spaces"
  type        = list(string)
  default     = ["10.0.24.0/24"]
}



