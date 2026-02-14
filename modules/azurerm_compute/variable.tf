variable "vms" {
  type = map(object({
    vm_name             = string
    location            = string
    resource_group_name = string
    vm_size             = string
    nic_name            = string
    ipconfig = map(object({
      name                          = string
      private_ip_address_allocation = string
    }))
    subnet_name = string
    vnet_name   = string
    pip_name    = string

    os-disk = map(object({
      caching              = string
      storage_account_type = optional(string, "Premium_LRS")
      disk_size_gb         = optional(number, 10)
    }))

    source_image_reference = map(string)
    kv_name                = string
    vm-username            = string
    vm-password            = string
    tags                   = optional(map(string))

    additional-capabilities = optional(map(object({
      ultra_ssd_enabled   = bool
      hibernation_enabled = bool
    })))
  }))
}
