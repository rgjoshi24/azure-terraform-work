output "webserv_virtual_network_name" {
  description = "Virtual Network Name"
  value = azurerm_virtual_network.web_vnet.name
}

output "webserv_virtual_network_id" {
  description = "Virtual Network ID"
  value = azurerm_virtual_network.web_vnet.id
}

output "webserv_subnet_name" {
  description = "WebTier Subnet Name"
  value = azurerm_subnet.web_subnet.name
}

output "webserv_subnet_id" {
  description = "WebTier Subnet ID"
  value = azurerm_subnet.web_subnet.id
}

output "webserv_subnet_nsg_name" {
  description = "WebTier Subnet NSG Name"
  value = azurerm_network_security_group.web_subnet_nsg.name
}

output "webserv_subnet_nsg_id" {
  description = "WebTier Subnet NSG ID"
  value = azurerm_network_security_group.web_subnet_nsg.id
}
