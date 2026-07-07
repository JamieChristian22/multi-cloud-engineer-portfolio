#!/usr/bin/env bash
set -euo pipefail
echo "Run terraform destroy from the selected cloud folder after reviewing the plan."
echo "Example: cd aws && terraform destroy -var-file=../envs/dev/aws.tfvars.example"
