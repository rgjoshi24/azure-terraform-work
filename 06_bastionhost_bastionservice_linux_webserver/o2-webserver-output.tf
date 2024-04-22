##########################
## Webserver Azure Linux - Output ##
##########################

output "webserver_vm_name" {
  description = "WebServer Virtual Machine name"
  value       = azurerm_linux_virtual_machine.linux_webserv.name
}

## Virtual Machine Private IP
output "webserver_linuxvm_private_ip_address" {
  description = "Web Linux Virtual Machine Private IP"
  value       = azurerm_linux_virtual_machine.linux_webserv.private_ip_address
}

output "webserver_vm_admin_username" {
  description = "Username for the WebServer Virtual Machine"
  value       = var.webserv_admin_username
  sensitive   = true
}

