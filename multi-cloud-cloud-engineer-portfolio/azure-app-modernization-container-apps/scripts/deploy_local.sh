#!/usr/bin/env bash
set -euo pipefail

cd terraform
terraform init
terraform plan
terraform apply -auto-approve

echo ""
echo "Next: build & push the image to ACR, then update Container App."
echo "Use scripts/push_image_to_acr.sh after Terraform outputs the ACR login server."
