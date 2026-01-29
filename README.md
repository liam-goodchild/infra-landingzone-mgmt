# Landing Zone Management Infrastructure

## Purpose

This repository defines the management deployment for the Azure Landing Zone, including monitoring resources and Azure Monitor Baseline Alerts (AMBA).

The goal is to establish a consistent, policy-driven monitoring foundation across the Azure environment.

This repository:

- Deploys Azure Monitor Baseline Alerts across the management group hierarchy
- Manages RBAC groups and role assignments for governance
- Provides multi-environment support (development and production)
- Enforces standardised tagging and naming conventions

---

## Architecture Overview

This deployment targets the following management group hierarchy:

```
Sky Haven (root)
├── Platform
│   ├── Connectivity
│   ├── Identity
│   ├── Management
│   ├── Security
│   └── Shared
├── Landing Zones
├── Decommissioned
└── Sandbox
```

### Components Deployed

| Component | Description |
|-----------|-------------|
| **AMBA Policies** | Baseline monitoring policies applied to management groups |
| **Alert Resource Group** | Dedicated resource group for alert resources |
| **User-Assigned Managed Identity** | Identity for AMBA operations |
| **RBAC Groups** | Security groups with Owner, Contributor, and Reader roles |
| **Action Groups** | Email notification channels for alerts |

---

## AMBA Integration

Azure Monitor Baseline Alerts are deployed via the ALZ architecture module, applying policies to the following archetypes:

- `amba_root` - Root management group policies
- `amba_platform` - Platform management group policies
- `amba_landing_zones` - Landing zone baseline alerts
- `amba_connectivity` - Network connectivity monitoring
- `amba_identity` - Identity and IAM monitoring
- `amba_management` - Management plane monitoring

### Alert Opt-Out

Resources can opt-out of monitoring via the `MonitorDisable` tag with the following values:
- `true`
- `Test`
- `Dev`
- `Sandbox`

---

## Environment Configuration

### Naming Convention

| Format | Pattern | Example |
|--------|---------|---------|
| Long | `{project}-mgmt-{env}-{location}-{resource}-{instance}` | `sh-mgmt-dev-uks-alerts-rg-01` |
| Short | `{project}mgmt{env_short}{location_short}{resource}{instance}` | `shmgmtNuks` |

### Environments

| Environment | Location | AMBA Enabled |
|-------------|----------|--------------|
| Development | UK South | No |
| Production | UK South | Yes |

---

## CI/CD Pipelines

| Pipeline | Trigger | Purpose |
|----------|---------|---------|
| `ci-terraform.yaml` | Pull Requests | Validation, linting, and plan |
| `cd-terraform.yaml` | Commits to main | Production deployment with versioning |
| `dev-terraform.yaml` | Manual | Development testing |
| `destroy-terraform.yaml` | Manual | Infrastructure teardown |

### Pipeline Stages

**CI Pipeline:**
1. Super-Linter and Prettier validation
2. Checkov security scanning
3. Terraform documentation generation
4. Terraform plan

**CD Pipeline:**
1. Terraform plan
2. Terraform apply
3. Semantic version tagging

---

## State Management

| Environment | Resource Group | Storage Account | Container |
|-------------|----------------|-----------------|-----------|
| Development | `sh-mgmt-dev-uks-tf-rg-01` | `shmgmtdevukstfst01` | `infra-landingzone-mgmt` |
| Production | `sh-mgmt-prd-uks-tf-rg-01` | `shmgmtprdukstfst01` | `infra-landingzone-mgmt` |

---

## Terraform Documentation

<!-- prettier-ignore-start -->
<!-- textlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_alz"></a> [alz](#requirement\_alz) | >= 0.17.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >= 2.0.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | >= 3.0, < 4.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.0 |

## Resources

| Name | Type |
|------|------|
| [azuread_group.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group_member.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azurerm_role_assignment.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azapi_client_config.current](https://registry.terraform.io/providers/Azure/azapi/latest/docs/data-sources/client_config) | data source |
| [azuread_group.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alz_architecture"></a> [alz\_architecture](#module\_alz\_architecture) | Azure/avm-ptn-alz/azurerm | 0.12.0 |
| <a name="module_amba_alz"></a> [amba\_alz](#module\_amba\_alz) | Azure/avm-ptn-monitoring-amba-alz/azurerm | 0.3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Name of Azure environment. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Resource location for Azure resources. | `string` | n/a | yes |
| <a name="input_management_subscription_id"></a> [management\_subscription\_id](#input\_management\_subscription\_id) | Management subscription ID where monitoring resources are deployed. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Project short name. | `string` | n/a | yes |
| <a name="input_rbac_groups"></a> [rbac\_groups](#input\_rbac\_groups) | Groups RBAC Configuration. | <pre>list(object({<br/>    name                = string<br/>    group_members_names = optional(list(string))<br/>    role_definitions    = optional(list(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_root_management_group_name"></a> [root\_management\_group\_name](#input\_root\_management\_group\_name) | Root management group name for the ALZ architecture. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Environment tags. | `map(string)` | n/a | yes |
| <a name="input_action_group_emails"></a> [action\_group\_emails](#input\_action\_group\_emails) | List of email addresses for AMBA action group notifications. | `list(string)` | `[]` | no |
| <a name="input_amba_disable_tag_name"></a> [amba\_disable\_tag\_name](#input\_amba\_disable\_tag\_name) | Tag name used to disable monitoring at the resource level. | `string` | `"MonitorDisable"` | no |
| <a name="input_amba_disable_tag_values"></a> [amba\_disable\_tag\_values](#input\_amba\_disable\_tag\_values) | Tag value(s) used to disable monitoring at the resource level. | `list(string)` | <pre>[<br/>  "true",<br/>  "Test",<br/>  "Dev",<br/>  "Sandbox"<br/>]</pre> | no |
| <a name="input_deploy_amba"></a> [deploy\_amba](#input\_deploy\_amba) | Whether to deploy Azure Monitor Baseline Alerts (AMBA) policies and resources. | `bool` | `false` | no |
| <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry) | Enable telemetry for the ALZ module. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
<!-- textlint-enable -->
<!-- prettier-ignore-end -->

---

## Summary

This repository provides the foundational monitoring and governance infrastructure for the Azure Landing Zone, deploying AMBA policies and RBAC controls across the management group hierarchy.
