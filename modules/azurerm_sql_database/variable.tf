variable "mssql_db" {
  type = map(object({
    name                = string
    collation           = string
    license_type        = string
    max_size_gb         = number
    sku_name            = string
    enclave_type        = string
    mssql_server_name   = string
    resource_group_name = string
  }))
}
