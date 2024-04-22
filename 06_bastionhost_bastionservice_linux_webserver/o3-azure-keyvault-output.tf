output "azure_key_vault_name" {
  description = "Azure Key Vault Name"
  value       = azurerm_key_vault.azure_key_vault.name
  sensitive   = true
}

output "azure_key_vault_id" {
  description = "Azure Key Vault Id"
  value       = azurerm_key_vault.azure_key_vault.id
  sensitive   = true
}