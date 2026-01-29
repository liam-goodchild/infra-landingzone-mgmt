locals {
  tags = merge(
    {
      # Required tags
      Environment  = var.environment == "prd" ? "Prod" : title(var.environment)
      Criticality  = "High"
      BusinessUnit = "Infrastructure"
      Owner        = "infrastructure@version1.com"
      CostCenter   = "Platform"
      Application  = "Azure-Landing-Zone"
      OpsTeam      = "Cloud-Operations"

      # Optional tags
      Repo    = "caf-tf-az-infra-mgmt"
      Project = "CAF"
    },
    var.tags
  )
}
