terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.59.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "7b0035a3-2bdd-440f-b694-5b328a80d3bd"
}