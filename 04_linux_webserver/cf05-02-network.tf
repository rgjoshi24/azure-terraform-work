# Create Virtual Network
resource "azurerm_virtual_network" "web_vnet" {
  name                = "${local.resource_name_prefix}-${var.vnet_name}"
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
  tags                = local.common_tags
}

resource "azurerm_subnet" "web_subnet" {
  name                 = "${azurerm_virtual_network.web_vnet.name}-${var.webserver_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg-tf.name
  virtual_network_name = azurerm_virtual_network.web_vnet.name
  address_prefixes     = var.webserver_subnet_address
}

resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                = "${azurerm_subnet.web_subnet.name}-nsg"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
}

resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_assn" {
  depends_on                = [azurerm_network_security_rule.web_nsg_inbound_rule]
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}

locals {
  web_inbound_port_map = {
    "1010" : "80",
    "1022" : "22"
  }
}

resource "azurerm_network_security_rule" "web_nsg_inbound_rule" {
  for_each                    = local.web_inbound_port_map
  name                        = "inbound-port-rule-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-tf.name
  network_security_group_name = azurerm_network_security_group.web_subnet_nsg.name
}

resource "azurerm_public_ip" "webserv_ip" {
  depends_on = [azurerm_resource_group.rg-tf]

  name                = "${azurerm_subnet.web_subnet.name}-ip"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
  allocation_method   = "Static"
  tags                = local.common_tags
}

resource "azurerm_network_interface" "webserv_nic" {
  depends_on = [azurerm_resource_group.rg-tf]

  name                = "${azurerm_subnet.web_subnet.name}-nic"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name

  ip_configuration {
    name                          = "${azurerm_subnet.web_subnet.name}-internal-ip"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webserv_ip.id
  }

  tags = local.common_tags
}