# Create Virtual Network
resource "azurerm_subnet" "bastion_subnet" {
  name                 = "${azurerm_virtual_network.web_vnet.name}-${var.bastion_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg-tf.name
  virtual_network_name = azurerm_virtual_network.web_vnet.name
  address_prefixes     = var.bastion_subnet_address
}

resource "azurerm_network_security_group" "bastion_subnet_nsg" {
  name                = "${azurerm_subnet.bastion_subnet.name}-nsg"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
}

resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_assn" {
  depends_on                = [azurerm_network_security_rule.bastion_nsg_inbound_rule]
  subnet_id                 = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
}

locals {
  bastion_inbound_port_map = {
    "100" : "22",
    "101" : "3389"
  }
}

data "http" "my-workstation-ip" {
  url = "http://ipv4.icanhazip.com"
}

resource "azurerm_network_security_rule" "bastion_nsg_inbound_rule" {
  for_each                    = local.bastion_inbound_port_map
  name                        = "bastion-inbound-port-rule-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "${chomp(data.http.my-workstation-ip.response_body)}/32"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-tf.name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}

resource "azurerm_public_ip" "bastion_ip" {
  depends_on = [azurerm_resource_group.rg-tf]

  name                = "${azurerm_subnet.bastion_subnet.name}-ip"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name
  allocation_method   = "Static"
  tags                = local.common_tags
}

resource "azurerm_network_interface" "bastion_nic" {
  depends_on = [azurerm_resource_group.rg-tf]

  name                = "${azurerm_subnet.bastion_subnet.name}-nic"
  location            = azurerm_resource_group.rg-tf.location
  resource_group_name = azurerm_resource_group.rg-tf.name

  ip_configuration {
    name                          = "${azurerm_subnet.bastion_subnet.name}-internal-ip"
    subnet_id                     = azurerm_subnet.bastion_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_ip.id
  }

  tags = local.common_tags
}