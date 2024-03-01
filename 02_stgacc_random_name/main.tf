# Terraform Block
terraform {
  required_version = "~> 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.43.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

# Default Provider
provider "azurerm" {
  features {}
}

resource "random_string" "random_str" {
  length  = 8
  special = false
  upper = false
}

# Simple Resource Group Creation
resource "azurerm_resource_group" "rg-auto" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_storage_account" "rg-auto-storage" {
  name                     = "${var.storage_account_name}${random_string.random_str.id}"
  resource_group_name      = azurerm_resource_group.rg-auto.name
  location                 = azurerm_resource_group.rg-auto.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}