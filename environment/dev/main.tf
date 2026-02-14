module "rgs" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.p_rgs
}
module "stg_account" {
  depends_on = [module.rgs]
  source     = "../../modules/azurerm_storage_account"
  storage    = var.p_storage
}
module "networks" {
  depends_on = [module.rgs]
  source     = "../../modules/azurerm_networking"
  networks   = var.p_networks
}
module "sqlserver" {
  depends_on = [module.rgs]
  source     = "../../modules/azurerm_sql_server"
  ms_sql     = var.p_ms_sql
}
module "mssqldb" {
  depends_on = [module.sqlserver]
  source     = "../../modules/azurerm_sql_database"
  mssql_db   = var.p_mssql_db
}
module "pips" {
  depends_on = [module.rgs]
  source     = "../../modules/azurerm_pip"
  pips       = var.p_pips
}
module "kvs" {
  depends_on = [module.rgs]
  source     = "../../modules/azurerm_keyvault"
  kvs        = var.p_kvs
}
module "vms" {
  depends_on = [module.networks]
  source     = "../../modules/azurerm_compute"
  vms        = var.p_vms
}
