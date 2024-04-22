# Create Virtual Network
resource "azurerm_subnet" "bastion_service_subnet" {
  name                 = var.bastion_service_subnet_name
  resource_group_name  = azurerm_resource_group.rg-tf.name
  virtual_network_name = azurerm_virtual_network.web_vnet.name
  address_prefixes     = var.bastion_service_subnet_address
}

resource "azurerm_public_ip" "bastion_service_ip" {
  name                = "${local.resource_name_prefix}-${var.vnet_name}-bastion-service-ip"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
  allocation_method   = "Static"
  sku = "Standard"
  tags                = local.common_tags
}
