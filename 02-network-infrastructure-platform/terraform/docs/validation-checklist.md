# Validation Checklist

## Terraform
- [ ] `terraform fmt -recursive`
- [ ] `terraform init`
- [ ] `terraform validate`
- [ ] `terraform plan`

## AWS evidence
- [ ] VPC created
- [ ] Public and private subnets created
- [ ] Route tables created
- [ ] Internet gateway attached
- [ ] Security group scoped to approved CIDR

## Azure evidence
- [ ] Resource group created
- [ ] VNet created
- [ ] Subnets created
- [ ] NSG created
- [ ] NSG associated to subnets

## GCP evidence
- [ ] Custom VPC created
- [ ] Regional subnets created
- [ ] Firewall rule created
- [ ] No broad admin access exposed
