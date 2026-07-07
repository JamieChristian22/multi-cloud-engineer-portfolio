# Network Design

This project demonstrates segmented cloud networking across AWS, Azure, and GCP.

## Design principles

- Separate public and private network zones
- Use least-privilege admin access
- Use environment-based CIDR ranges
- Keep reusable modules separate from cloud-specific root configurations
- Use consistent naming and tags/labels for cost and operations visibility

## CIDR plan

| Cloud | Dev CIDR | Prod CIDR |
|---|---:|---:|
| AWS | 10.20.0.0/16 | 10.120.0.0/16 |
| Azure | 10.30.0.0/16 | 10.130.0.0/16 |
| GCP | 10.40.0.0/16 | 10.140.0.0/16 |

## Interview talking points

- Explain why private subnets reduce exposure.
- Explain why admin access should be restricted to a known public IP.
- Explain why separate CIDR ranges prevent future overlap in hybrid or multi-cloud routing.
- Explain how route tables, NSGs/security groups, and firewall rules differ across providers.
