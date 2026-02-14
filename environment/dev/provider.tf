terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.59.0"
    }
  }
  # backened block
  backend "azurerm" {
    resource_group_name  = "test-rg5678"
    storage_account_name = "teststorage043187"
    container_name       = "tf-container"
    key                  = "tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "7b0035a3-2bdd-440f-b694-5b328a80d3bd"
}
