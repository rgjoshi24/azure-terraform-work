resource "azurerm_linux_virtual_machine" "linux_webserv" {
  depends_on = [azurerm_network_interface.webserv_nic]

  name                  = "${local.resource_name_prefix}-${var.vnet_name}-webserv"
  location              = azurerm_resource_group.rg-tf.location
  resource_group_name   = azurerm_resource_group.rg-tf.name
  network_interface_ids = [azurerm_network_interface.webserv_nic.id]
  size                  = var.webserv_vm_size

  source_image_reference {
    offer     = lookup(var.webserv_vm_image, "offer", null)
    publisher = lookup(var.webserv_vm_image, "publisher", null)
    sku       = lookup(var.webserv_vm_image, "sku", null)
    version   = lookup(var.webserv_vm_image, "version", null)
  }

  os_disk {
    name                 = "${azurerm_subnet.web_subnet.name}-linux_webserv-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  computer_name  = "${local.resource_name_prefix}-${var.vnet_name}-webserv"
  admin_username = var.webserv_admin_username
  admin_password = random_password.linux-vm-password.result
  custom_data    = base64encode(data.template_file.webserv-cloud-init.rendered)

  disable_password_authentication = false

  tags = local.common_tags
}

data "template_file" "webserv-cloud-init" {
  template = file("d01-webserver_init.sh")
}
