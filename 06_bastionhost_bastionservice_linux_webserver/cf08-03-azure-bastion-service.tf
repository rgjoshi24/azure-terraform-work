resource "azurerm_bastion_host" "bastion_service_host" {
  name                = "${local.resource_name_prefix}-${var.vnet_name}-bastion-service"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name

  ip_configuration {
    name                 = "bastion-service-ip"
    subnet_id            = azurerm_subnet.bastion_service_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_service_ip.id
  }
}