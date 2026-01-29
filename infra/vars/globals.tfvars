#########################################
# Generic
#########################################
project = "sh"

#########################################
# Azure Monitor Baseline Alerts
#########################################
deploy_amba                = true
root_management_group_name = "sky-haven"

#########################################
# RBAC
#########################################
rbac_groups = [
  {
    name                = "Owner"
    group_members_names = []
    role_definitions = [
      "Owner"
    ]
  },
  {
    name                = "Contributor"
    group_members_names = []
    role_definitions = [
      "Contributor"
    ]
  },
  {
    name                = "Reader"
    group_members_names = []
    role_definitions = [
      "Reader"
    ]
  }
]
