resource "azurerm_mssql_server" "mssql" {
  for_each                     = var.ms_sql
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = "mradministrator"
  administrator_login_password = "ThisIsAjay"
  minimum_tls_version          = each.value.minimum_tls_version
}


