#########################################
# Generic
#########################################
environment = "prd"
location    = "uksouth"

tags = {
  Environment = "Prod"
  Purpose     = "AMBA Monitoring"
}

#########################################
# Management Subscription
#########################################
management_subscription_id = "48a8b708-dc42-468f-97bc-fd949c073eb8"

#########################################
# AMBA Configuration
#########################################
action_group_emails     = ["alerts@example.com"]
amba_disable_tag_name   = "MonitorDisable"
amba_disable_tag_values = ["true", "Test", "Dev", "Sandbox"]
