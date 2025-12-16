#!/usr/bin/env bash
set -euo pipefail

# Builds and pushes the app image to ACR with the tag expected by Terraform.
cd "$(dirname "$0")/.."

ACR_LOGIN_SERVER=$(terraform -chdir=terraform output -raw acr_login_server)

az acr login --name "${ACR_LOGIN_SERVER%%/*}"

docker build -t "$ACR_LOGIN_SERVER/app:latest" ./app
docker push "$ACR_LOGIN_SERVER/app:latest"

echo "Image pushed: $ACR_LOGIN_SERVER/app:latest"
