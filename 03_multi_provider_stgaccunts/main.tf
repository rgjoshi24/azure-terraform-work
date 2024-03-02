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

# Provider 2 for Central US
provider "azurerm" {
  features {
    virtual_machine {
      delete_os_disk_on_deletion = false
    }
  }
  alias = "provider2-centralus"
}

resource "random_string" "random_str" {
  length  = 8
  special = false
  upper   = false
}

# Simple Resource Group Creation
resource "azurerm_resource_group" "rg-auto-prod" {
  name     = var.resource_group_prod
  location = var.prodlocation
}

resource "azurerm_resource_group" "rg-auto-dr" {
  name     = var.resource_group_dr
  location = var.drlocation
  provider = azurerm.provider2-centralus
}

resource "azurerm_storage_account" "rg-auto-prod-storage" {
  name                     = "${var.storage_account_name_prod}${random_string.random_str.id}"
  resource_group_name      = azurerm_resource_group.rg-auto-prod.name
  location                 = azurerm_resource_group.rg-auto-prod.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_account" "rg-auto-dr-storage" {
  name                     = "${var.storage_account_name_dr}${random_string.random_str.id}"
  resource_group_name      = azurerm_resource_group.rg-auto-dr.name
  location                 = azurerm_resource_group.rg-auto-dr.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}