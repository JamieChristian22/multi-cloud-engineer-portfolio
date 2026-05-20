# Security, Cost, and Operations Notes

## Security Controls

- HTTPS-only App Service configuration.
- HTTPS-only Storage Account enforcement.
- Private blob container access.
- Network Security Group rules for controlled HTTP/HTTPS access.
- Azure Key Vault with RBAC authorization.
- No secrets committed to GitHub.
- Terraform state and local variable files excluded from Git.

## Cost Controls

- Free-tier/low-cost App Service SKU through `app_service_sku` variable.
- Standard LRS storage instead of premium storage.
- No NAT Gateway, Application Gateway, Front Door, or premium firewall.
- 30-day Log Analytics retention.
- Cleanup script and Terraform destroy command included.

## Operational Controls

- Terraform enables repeatable provisioning.
- Azure Monitor metric alert watches for high CPU.
- Application Insights provides application telemetry.
- Log Analytics centralizes monitoring data.
- Tags support resource ownership and cost tracking.
