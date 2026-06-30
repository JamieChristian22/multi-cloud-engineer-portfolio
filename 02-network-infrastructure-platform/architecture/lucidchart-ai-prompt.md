# Lucidchart AI Prompt

Create a professional multi-cloud network infrastructure architecture diagram titled:

**Project 02 - Multi-Cloud Network Infrastructure Platform**

Use official AWS, Azure, and Google Cloud icons. White background. Enterprise architecture style. Show three cloud sections side by side:

1. AWS Network Foundation
- VPC `enterprise-network-vpc` CIDR `10.20.0.0/16`
- Public subnet `10.20.1.0/24`
- Private subnet `10.20.2.0/24`
- Internet Gateway
- NAT Gateway
- Bastion EC2
- Private application EC2
- CloudWatch VPC Flow Logs
- SNS alerts
- SSM managed node

2. Azure Network Foundation
- Resource group `rg-network-infrastructure-platform`
- VNet `vnet-enterprise-network`
- Public subnet `10.20.1.0/24`
- Private subnet `10.20.2.0/24`
- Public Linux VM
- Private Linux VM
- Network Security Groups
- Azure Bastion

3. GCP Network Foundation
- Project `network-infrastructure`
- VPC `vpc-enterprise-network`
- Firewall rule `allow-web-traffic`
- Compute Engine VM `enterprise-web-vm`
- Nginx web server
- External IP `35.243.178.223`

Show traffic flow from Internet Users to public web tiers. Show private tier segmentation and management access paths. Include a legend for public access, private access, monitoring, and backup.
