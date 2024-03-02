output "prod_resource_group_name" {
  value = azurerm_resource_group.rg-auto-prod.name
}

output "prod_storage_account_name" {
  value = azurerm_storage_account.rg-auto-prod-storage.name
}

output "dr_resource_group_name" {
  value = azurerm_resource_group.rg-auto-dr.name
}

output "dr_storage_account_name" {
  value = azurerm_storage_account.rg-auto-dr-storage.name
}
