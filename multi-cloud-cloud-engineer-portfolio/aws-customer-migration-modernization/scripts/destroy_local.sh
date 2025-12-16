#!/usr/bin/env bash
set -euo pipefail

cd terraform/envs/dev
terraform destroy -auto-approve
