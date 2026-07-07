# Implementation Guide

## Goal
Create a secure, interview-ready multi-cloud storage and data platform using Terraform.

## AWS evidence
- S3 bucket overview
- Public access block enabled
- Versioning enabled
- Encryption enabled
- Lifecycle rule enabled

## Azure evidence
- Resource group
- Storage account overview
- Private blob container
- Minimum TLS 1.2
- Blob versioning and soft delete

## GCP evidence
- GCS bucket overview
- Public access prevention enforced
- Uniform bucket-level access enabled
- Versioning enabled
- Lifecycle rules

## Best practice talking points
- Encryption at rest protects stored data.
- Versioning supports accidental deletion recovery.
- Lifecycle rules reduce long-term storage cost.
- Public access blocking reduces exposure risk.
- Separate dev/prod variables support environment isolation.
