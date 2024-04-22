output "bastion_vm_name" {
  description = "Bastion Virtual Machine name"
  value       = azurerm_linux_virtual_machine.linux_bastion.name
}

output "bastion_vm_ip_address" {
  description = "Bastion Virtual Machine IP Address"
  value       = azurerm_public_ip.bastion_ip.ip_address
}

output "bastion_vm_admin_username" {
  description = "Username password for the Virtual Machine"
  value       = var.bastion_admin_username
  sensitive   = true
}
