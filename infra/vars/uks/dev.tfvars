#########################################
# Generic
#########################################
environment = "nprd"
location    = "uksouth"

tags = {
  Environment = "PreProd"
  Purpose     = "AMBA Monitoring"
}

#########################################
# Management Subscription
#########################################
management_subscription_id = "48a8b708-dc42-468f-97bc-fd949c073eb8"

#########################################
# AMBA Configuration
#########################################
action_group_emails     = ["liamgoodchild12@hotmail.co.uk"]
amba_disable_tag_name   = "MonitorDisable"
amba_disable_tag_values = ["true", "Test", "Dev", "Sandbox"]
