variable "ms_sql" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    version             = string
    minimum_tls_version = string
  }))
}