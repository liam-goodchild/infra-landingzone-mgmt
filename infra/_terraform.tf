terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">= 2.0.0"
    }
    alz = {
      source  = "Azure/alz"
      version = ">= 0.17.0"
    }
  }

  backend "azurerm" {}
}
