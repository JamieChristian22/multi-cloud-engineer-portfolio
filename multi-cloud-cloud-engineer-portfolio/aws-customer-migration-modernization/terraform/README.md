# Terraform

This folder contains reusable modules and a runnable `dev` environment.

## Layout
- `modules/` reusable, environment-agnostic Terraform modules
- `envs/dev/` a complete composed environment using the modules

## Recommended backend
S3 remote state + DynamoDB locking (see `envs/dev/backend.tf`).
