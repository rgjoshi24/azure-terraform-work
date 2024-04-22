resource "tls_private_key" "tls_key_rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "ssh-public-key" {
  key_vault_id = azurerm_key_vault.azure_key_vault.id
  name         = "ssh-public-key-rsa"
  value        = tls_private_key.tls_key_rsa.public_key_openssh
}

resource "azurerm_key_vault_secret" "ssh-private-key" {
  key_vault_id = azurerm_key_vault.azure_key_vault.id
  name         = "ssh-private-key-rsa"
  value        = tls_private_key.tls_key_rsa.private_key_pem
}

resource "local_file" "local-ssh-private-key" {
  content         = tls_private_key.tls_key_rsa.private_key_pem
  filename        = "${path.module}/id_rsa"
  file_permission = "0400"
}

resource "local_file" "local-ssh-public-key" {
  content  = tls_private_key.tls_key_rsa.public_key_openssh
  filename = "${path.module}/id_rsa.pub"
}