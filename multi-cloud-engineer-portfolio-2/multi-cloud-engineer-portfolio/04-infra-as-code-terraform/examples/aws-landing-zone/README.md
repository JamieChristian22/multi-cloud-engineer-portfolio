# AWS Landing Zone Example

This example composes the `network` module to stand up a basic AWS landing zone:

- 1 VPC
- 2 public subnets
- 2 private subnets
- Internet gateway and public route table

## Usage

```bash
terraform init
terraform plan -var="name=jamie-landing-zone" -var="region=us-east-1"
# terraform apply
```
