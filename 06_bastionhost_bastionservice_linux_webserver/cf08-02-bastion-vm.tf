
resource "azurerm_linux_virtual_machine" "linux_bastion" {
  depends_on = [azurerm_network_interface.bastion_nic]

  name                  = "${local.resource_name_prefix}-${var.vnet_name}-bastion"
  location              = azurerm_resource_group.rg-tf.location
  resource_group_name   = azurerm_resource_group.rg-tf.name
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  size                  = var.bastion_vm_size

  source_image_reference {
    offer     = lookup(var.bastion_vm_image, "offer", null)
    publisher = lookup(var.bastion_vm_image, "publisher", null)
    sku       = lookup(var.bastion_vm_image, "sku", null)
    version   = lookup(var.bastion_vm_image, "version", null)
  }

  os_disk {
    name                 = "${azurerm_subnet.bastion_subnet.name}-linux_bastion-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  admin_ssh_key {
    username   = var.bastion_admin_username
    public_key = data.azurerm_key_vault_secret.ssh-public-key-rsa.value
  }

  computer_name  = "${local.resource_name_prefix}-${var.vnet_name}-bastion"
  admin_username = var.bastion_admin_username

  tags = local.common_tags
}

