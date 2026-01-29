provider "azuread" {}

provider "alz" {
  library_overwrite_enabled = true
  library_references = [
    {
      "path" : "platform/alz",
      "ref" : "2025.09.3"
    },
    {
      "path" : "platform/amba",
      "ref" : "2025.05.0"
    },
    {
      custom_url = "${path.root}/lib"
    }
  ]
}

provider "azurerm" {
  features {}
  subscription_id = var.management_subscription_id
}

provider "azapi" {}
