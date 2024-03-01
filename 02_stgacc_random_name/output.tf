output "resource_group_name" {
  value = azurerm_resource_group.rg-auto.name
}

output "storage_account_name" {
  value = azurerm_storage_account.rg-auto-storage.name
}
