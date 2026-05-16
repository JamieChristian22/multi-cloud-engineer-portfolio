# 02_Azure_Terraform_Infrastructure

## Project Overview
This Terraform project recreates the Azure Enterprise Cloud Platform infrastructure built in the Azure Portal screenshots. All values are filled in using the actual portfolio resource names from the project.

## Actual Azure Resource Values Used

| Category | Value |
|---|---|
| Subscription Name | Azure subscription 1 |
| Resource Group | rg-enterprise-infra |
| Region | East US |
| Virtual Network | vnet-enterprise |
| VNet Address Space | 10.0.0.0/16 |
| Subnet | app-subnet |
| Subnet CIDR | 10.0.0.0/24 |
| Network Security Group | nsg-enterprise |
| HTTP Rule | allow-http, TCP 80, Priority 100 |
| HTTPS Rule | allow-https, TCP 443, Priority 110 |
| Storage Account | stenterprisefiles |
| Blob Container | project-files |
| Blob Access Level | Private |
| Key Vault | kv-enterprise-demo |
| Key Vault Secret | db-password |
| App Service Plan | ASP-rgenterpriseinfra-a004 |
| Web App | enterprise-app-demo |
| Runtime Stack | Node.js 22 LTS |
| Operating System | Linux |
| SKU | Free F1 |
| Monitoring Metric | Requests |
| Alert Threshold | Greater than 5 requests |
| Evaluation Frequency | Every 5 minutes |
| Lookback Period | 5 minutes |

## Folder Contents

```text
02_Azure_Terraform_Infrastructure/
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
```

## Architecture

```text
Internet Users
      ↓
Azure Linux Web App: enterprise-app-demo
      ↓
App Service Plan: ASP-rgenterpriseinfra-a004
      ↓
Virtual Network: vnet-enterprise
      ↓
Subnet: app-subnet / 10.0.0.0/24
      ↓
Network Security Group: nsg-enterprise
      ↓
Azure Storage Account: stenterprisefiles
      ↓
Blob Container: project-files
      ↓
Azure Key Vault: kv-enterprise-demo
      ↓
Azure Monitor Request Metrics + Alert Rule
```

## Terraform Commands

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Destroy resources:

```bash
terraform destroy
```

## Important Note
These files are filled in with the exact project names used in the screenshots. Azure Storage Account and Key Vault names must be globally unique across Azure. These names match the existing project; if redeploying into a different tenant or subscription and the names are unavailable, rename only those two values in `terraform.tfvars`.
