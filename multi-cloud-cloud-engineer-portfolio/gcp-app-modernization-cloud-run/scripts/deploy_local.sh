#!/usr/bin/env bash
set -euo pipefail

cd terraform
terraform init
terraform plan
terraform apply -auto-approve
