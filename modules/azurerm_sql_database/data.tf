data "azurerm_mssql_server" "data_mssqlserver" {
  for_each = var.mssql_db
  name                = each.value.mssql_server_name
  resource_group_name = each.value.resource_group_name
}