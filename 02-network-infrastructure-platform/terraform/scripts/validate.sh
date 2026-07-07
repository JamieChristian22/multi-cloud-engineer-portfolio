#!/usr/bin/env bash
set -euo pipefail
terraform fmt -recursive
for dir in aws azure gcp; do
  echo "Validating $dir"
  (cd "$dir" && terraform init -backend=false && terraform validate)
done
