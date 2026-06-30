# Architecture - Network Infrastructure Platform

## Goal

Build a multi-cloud network foundation that demonstrates VPC/VNet design, public/private segmentation, firewall rules, bastion/SSM-style management, and web-tier validation.

## AWS Implementation

- VPC: `enterprise-network-vpc` with CIDR `10.20.0.0/16`
- Public subnet: `10.20.1.0/24`
- Private subnet: `10.20.2.0/24`
- Internet Gateway attached to the VPC
- Public route table with `0.0.0.0/0` to Internet Gateway
- Private route table with NAT Gateway route for outbound internet
- Bastion EC2 in public subnet
- Private application EC2 in private subnet
- CloudWatch VPC Flow Logs
- SNS alert topic
- SSM managed node validation
- AWS Backup plan assignment

## Azure Implementation

- Resource group: `rg-network-infrastructure-platform`
- VNet: `vnet-enterprise-network`
- Public subnet: `10.20.1.0/24`
- Private subnet: `10.20.2.0/24`
- Public VM: `enterprise-web-vm`
- Private VM: `enterprise-app-vm`
- NSGs for public and private subnet access control
- Azure Bastion for controlled private access

## GCP Implementation

- Project: `network-infrastructure`
- VPC: `vpc-enterprise-network`
- Web VM: `enterprise-web-vm`
- Firewall rule: `allow-web-traffic`
- Network tag: `web-server`
- Nginx web server validated using external IP `35.243.178.223`

## Traffic Flow

Internet users connect over HTTP to the public web VM. Firewall/security rules allow the required web traffic. Private resources remain segmented and are accessed through controlled management paths.
