# Terraform Block
terraform {
  required_version = "~> 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.43.0"
    }
  }
}

# Default Provider
provider "azurerm" {
  features {}
}

# Simple Resource Group Creation
resource "azurerm_resource_group" "rg-auto" {
  name     = var.resource_group
  location = var.location
}