module "amba_alz" {
  count   = var.deploy_amba ? 1 : 0
  source  = "Azure/avm-ptn-monitoring-amba-alz/azurerm"
  version = "0.3.0"

  location                            = var.location
  root_management_group_name          = var.root_management_group_name
  resource_group_name                 = local.resource_group_name
  user_assigned_managed_identity_name = local.user_assigned_managed_identity_name
  tags                                = local.tags
}

module "alz_architecture" {
  count   = var.deploy_amba ? 1 : 0
  source  = "Azure/avm-ptn-alz/azurerm"
  version = "0.12.0"

  architecture_name  = "amba-only"
  location           = var.location
  parent_resource_id = var.tenant_id
  enable_telemetry   = var.enable_telemetry

  policy_default_values = {
    amba_alz_management_subscription_id          = jsonencode({ value = var.management_subscription_id })
    amba_alz_resource_group_name                 = jsonencode({ value = local.resource_group_name })
    amba_alz_resource_group_location             = jsonencode({ value = var.location })
    amba_alz_resource_group_tags                 = jsonencode({ value = local.tags })
    amba_alz_user_assigned_managed_identity_name = jsonencode({ value = local.user_assigned_managed_identity_name })
    amba_alz_disable_tag_name   = jsonencode({ value = var.amba_disable_tag_name })
    amba_alz_disable_tag_values = jsonencode({ value = var.amba_disable_tag_values })
    amba_alz_action_group_email = jsonencode({ value = var.action_group_emails })
  }

  depends_on = [module.amba_alz]
}
