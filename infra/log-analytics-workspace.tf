# resource "azurerm_resource_group" "log_analytics" {
#   name     = "${local.prefix}-law-rg-01"
#   location = var.location
#   tags     = local.tags

#   lifecycle {
#     ignore_changes = [
#       tags["DeploymentDate"],
#       tags["Deployment-Date"]
#     ]
#   }
# }

# module "log_analytics" {
#   source = "git::https://version1ukdcs@dev.azure.com/version1ukdcs/Azure%20Capability%20Terraform%20Modules/_git/tf-az-mod-log-analytics?ref=1.1.0"

#   name                = "${local.prefix}-law-01"
#   resource_group_name = azurerm_resource_group.log_analytics.name
#   location            = azurerm_resource_group.log_analytics.location

#   tags = local.tags
# }
