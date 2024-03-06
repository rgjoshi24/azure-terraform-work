locals {
  owners               = var.business_unit
  environment          = var.environment
  resource_name_prefix = "${var.business_unit}-${var.environment}"
  common_tags = {
    owners      = local.owners
    environment = local.environment
  }
}