#!/usr/bin/env bash
set -euo pipefail

for dir in aws azure gcp; do
  echo "Validating $dir"
  (cd "$dir" && terraform fmt -recursive && terraform init -backend=false && terraform validate)
done
