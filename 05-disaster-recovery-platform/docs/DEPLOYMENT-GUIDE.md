# Deployment Guide - Disaster Recovery Platform

## Prerequisites

- AWS account with IAM permissions for EC2, VPC, CloudWatch, S3, and IAM as needed.
- Azure subscription with permission to create resource groups, VNets, VMs, storage, and monitoring resources.
- GCP project with billing enabled and Compute Engine API enabled.
- Local terminal with SSH access.

## Deployment Flow

1. Create the cloud resource group/project structure.
2. Deploy the network or platform foundation.
3. Deploy compute/storage/monitoring resources.
4. Apply security controls.
5. Validate the service.
6. Capture screenshots into `evidence/screenshots`.
7. Document what worked and what was fixed.

## Validation

Use provider consoles and terminal commands to verify resource status, network reachability, service availability, and logs/metrics.
