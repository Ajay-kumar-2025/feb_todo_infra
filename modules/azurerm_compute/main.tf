resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ipconfig
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = data.azurerm_subnet.subnet[each.key].id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = data.azurerm_public_ip.pip[each.key].id
    }
  }
}
resource "azurerm_linux_virtual_machine" "vms" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.vm_size
  admin_username                  = data.azurerm_key_vault_secret.vm_username[each.key].value
  admin_password                  = data.azurerm_key_vault_secret.vm_password[each.key].value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id]

  dynamic "os_disk" {
    for_each = each.value.os-disk
    content {
      caching              = os_disk.value.caching
      storage_account_type = os_disk.value.storage_account_type
      disk_size_gb         = os_disk.value.disk_size_gb
    }
  }
  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  tags = each.value.tags

  dynamic "additional_capabilities" {
    # for_each = each.value.additional-capabilities --> use this incase of directly pass blank map in variable.tf
    for_each = each.value.additional-capabilities == null ? {} : each.value.additional-capabilities
    content {
      ultra_ssd_enabled   = additional_capabilities.value.ultra_ssd_enabled
      hibernation_enabled = additional_capabilities.value.hibernation_enabled
    }
  }
}
