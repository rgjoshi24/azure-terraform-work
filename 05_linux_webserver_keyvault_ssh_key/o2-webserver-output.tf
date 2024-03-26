##########################
## Webserver Azure Linux - Output ##
##########################

output "webserver_vm_name" {
  description = "Virtual Machine name"
  value       = azurerm_linux_virtual_machine.linux_webserv.name
}

output "webserver_vm_ip_address" {
  description = "Virtual Machine name IP Address"
  value       = azurerm_public_ip.webserv_ip.ip_address
}

output "webserver_vm_admin_username" {
  description = "Username password for the Virtual Machine"
  value       = var.webserv_admin_username
  sensitive   = true
}

output "webserver_vm_admin_password" {
  description = "Administrator password for the Virtual Machine"
  value       = random_password.linux-vm-password.result
  sensitive   = true
}

