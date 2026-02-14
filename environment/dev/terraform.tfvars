p_rgs = {
  rg1 = {
    name       = "demo_rg"
    location   = "eastus"
    managed_by = "terraform"
    tags = {
      environment = "dev"
      owner       = "terraform"
    }
  }
  # rg2 = {
  #   name     = "demo_rg2"
  #   location = "westus"
  # }
}
p_storage = {
  stg1 = {
    name                     = "demostorageacc001"
    resource_group_name      = "demo_rg"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags = {
      environment = "dev"
    }
  }
}
p_networks = {
  vnet1 = {
    name                = "demo_vnet"
    location            = "eastus"
    resource_group_name = "demo_rg"
    address_space       = ["10.0.0.0/16"]

    subnets = [
      { name             = "frontend_subnet"
        address_prefixes = ["10.0.1.0/24"]
      },
      { name             = "backend_subnet"
        address_prefixes = ["10.0.2.0/24"]
    }]
    tags = {
      environment = "dev"
    }
  }
}
p_ms_sql = {
  msql1 = {
    name                = "demo-mssqlserver"
    resource_group_name = "demo_rg"
    location            = "eastus"
    version             = "12.0"
    minimum_tls_version = "1.2"
  }
}
p_mssql_db = {
  mssql_db1 = {
    name                = "demo-sqldb001"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = 10
    sku_name            = "S0"
    enclave_type        = "VBS"
    mssql_server_name   = "demo-mssqlserver"
    resource_group_name = "demo_rg"
  }
}
p_pips = {
  pip1 = {
    name                = "demo_pip"
    resource_group_name = "demo_rg"
    location            = "eastus"
    allocation_method   = "Static"
  }
}
p_kvs = {
  kv1 = {
    kv_name                     = "kv-frontend-001"
    location                    = "eastus"
    resource_group_name         = "demo_rg"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
  }
}

p_vms = {
  vm1 = {
    vm_name             = "vm_frontend001"
    location            = "eastus"
    resource_group_name = "demo_rg"
    vm_size             = "Standard_F2"
    kv_name             = "kv-frontend-001"
    vm-username         = "vm-username"
    vm-password         = "vm-password"
    nic_name            = "nic_frontend001"
    ipconfig = {
      ipconfig1 = {
        name                          = "ipconfig_frontendvm001"
        private_ip_address_allocation = "dynamic"
      }
      ipconfig2 = {
        name                          = "ipconfig_loadbalancer"
        private_ip_address_allocation = "dynamic"
      }
    }
    subnet_name = "subnet_frontend"
    vnet_name   = "demo_vnet"
    pip_name    = "pip_frontend"

    os-disk = {
      disk1 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 100
      }
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    tags = {
      Environment = "dev"
      Project     = "payment-app"
      Owner       = "devops-team"
      CostCenter  = "CC-1023"
      Application = "frontend"
    }
    additional-capabilities = {
      adc1 = {
        ultra_ssd_enabled   = true
        hibernation_enabled = true
      }
    }
  }

  vm2 = {
    vm_name             = "vm_backend001"
    location            = "eastus"
    resource_group_name = "demo_rg"
    vm_size             = "Standard_F2"
    kv_name             = "kv-frontend-001"
    vm-username         = "vm-username"
    vm-password         = "vm-password"
    nic_name            = "nic_backend001"
    ipconfig = {
      ipconfig1 = {
        name                          = "ipconfig_backendvm001"
        private_ip_address_allocation = "dynamic"
      }
      ipconfig2 = {
        name                          = "ipconfig_loadbalancer"
        private_ip_address_allocation = "dynamic"
      }
    }
    subnet_name = "subnet_backend"
    vnet_name   = "demo_vnet"
    pip_name    = "pip_backend"

    os-disk = {
      disk1 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 100
      }
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "24_04-lts"
      version   = "latest"
    }
    tags = {
      Environment = "dev"
      Project     = "payment-app"
      Owner       = "devops-team"
      CostCenter  = "CC-1023"
      Application = "backend"
    }
    additional-capabilities = {
      adc1 = {
        ultra_ssd_enabled   = true
        hibernation_enabled = true
      }
    }
  }
}
