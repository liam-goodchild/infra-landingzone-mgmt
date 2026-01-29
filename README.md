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
<!-- END_TF_DOCS -->
<!-- textlint-enable -->
<!-- prettier-ignore-end -->

---

## Summary

This repository provides the foundational monitoring and governance infrastructure for the Azure Landing Zone, deploying AMBA policies and RBAC controls across the management group hierarchy.
