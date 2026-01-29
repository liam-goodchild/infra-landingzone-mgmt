variable "location" {
  description = "Resource location for Azure resources."
  type        = string
}

variable "tags" {
  description = "Environment tags."
  type        = map(string)
}

variable "environment" {
  description = "Name of Azure environment."
  type        = string
}

variable "project" {
  description = "Project short name."
  type        = string
}

variable "rbac_groups" {
  description = "Groups RBAC Configuration."
  type = list(object({
    name                = string
    group_members_names = optional(list(string))
    role_definitions    = optional(list(string))
  }))
}

variable "management_subscription_id" {
  type        = string
  description = "Management subscription ID where monitoring resources are deployed."
}

variable "root_management_group_name" {
  type        = string
  description = "Root management group name for the ALZ architecture."
}

variable "amba_disable_tag_name" {
  type        = string
  default     = "MonitorDisable"
  description = "Tag name used to disable monitoring at the resource level."
}

variable "amba_disable_tag_values" {
  type        = list(string)
  default     = ["true", "Test", "Dev", "Sandbox"]
  description = "Tag value(s) used to disable monitoring at the resource level."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = "Enable telemetry for the ALZ module."
  nullable    = false
}

variable "action_group_emails" {
  type        = list(string)
  default     = []
  description = "List of email addresses for AMBA action group notifications."
}

variable "deploy_amba" {
  type        = bool
  default     = false
  description = "Whether to deploy Azure Monitor Baseline Alerts (AMBA) policies and resources."
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID. Required for AMBA policy deployment to resolve at plan time."
}
