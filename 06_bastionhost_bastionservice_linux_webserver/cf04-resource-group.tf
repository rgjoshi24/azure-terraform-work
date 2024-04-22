resource "azurerm_resource_group" "rg-tf" {
  name     = "${var.business_unit}-${var.environment}-${var.resource_group}"
  location = var.location
  tags     = local.common_tags
}