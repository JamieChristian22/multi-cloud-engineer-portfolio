# Architecture - Storage and Data Platform

## Goal

Create governed object storage across AWS, Azure, and GCP with encryption, versioning, lifecycle management, access control, and operational validation.

## AWS
- S3 bucket with versioning
- Server-side encryption using AES256 or KMS
- Block Public Access enabled
- Lifecycle policy for transition and expiration
- Access logging bucket

## Azure
- Storage account with secure transfer required
- Blob container for enterprise data
- Blob versioning and soft delete
- Lifecycle management policy
- RBAC access control

## GCP
- Cloud Storage bucket
- Uniform bucket-level access
- Versioning
- Lifecycle rule
- Public access prevention
