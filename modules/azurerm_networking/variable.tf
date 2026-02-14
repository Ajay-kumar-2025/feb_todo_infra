variable "networks" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    subnets = optional(list(object({
      name             = string
      address_prefixes = list(string)
    })), [])
    tags = optional(map(string))
  }))
}
