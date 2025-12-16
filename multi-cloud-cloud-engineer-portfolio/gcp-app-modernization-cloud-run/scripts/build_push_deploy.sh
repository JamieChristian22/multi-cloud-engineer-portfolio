#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

PROJECT_ID=$(terraform -chdir=terraform output -json | python -c 'import json,sys; o=json.load(sys.stdin); print(o.get("service_url",{}).get("value",""))' || true)
# Use configured gcloud project for docker auth
gcloud auth configure-docker "${TF_VAR_region:-us-east1}-docker.pkg.dev" -q

REGION=$(grep -E '^variable "region"' -n terraform/variables.tf >/dev/null && terraform -chdir=terraform console -json <<< 'var.region' | tr -d '"')
REPO=$(terraform -chdir=terraform output -raw artifact_registry_repo)

IMAGE="${REGION}-docker.pkg.dev/$(terraform -chdir=terraform console -json <<< 'var.project_id' | tr -d '"')/${REPO}/app:latest"

docker build -t "$IMAGE" ./app
docker push "$IMAGE"

echo "Image pushed: $IMAGE"
echo "Cloud Run will pull latest image on next revision update (Terraform manages the service)."
echo "If needed, re-apply Terraform to ensure service points to :latest."
terraform -chdir=terraform apply -auto-approve
