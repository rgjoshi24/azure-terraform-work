variable "webserv_vm_size" {
  type        = string
  description = "Size (SKU) of the virtual machine to create"
}

variable "webserv_vm_image" {
  type        = map(string)
  description = "Virtual machine source image information"
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

variable "webserv_admin_username" {
  description = "Username for Virtual Machine administrator account"
  type        = string
  default     = ""
}

variable "webserv_admin_password" {
  description = "Password for Virtual Machine administrator account"
  type        = string
  default     = ""
}