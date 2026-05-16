#!/usr/bin/env bash
set -euo pipefail

RESOURCE_GROUP="rg-enterprise-infra"

echo "This will delete the full Azure portfolio resource group: $RESOURCE_GROUP"
read -r -p "Type DELETE to continue: " CONFIRM

if [[ "$CONFIRM" != "DELETE" ]]; then
  echo "Cleanup cancelled."
  exit 0
fi

az group delete --name "$RESOURCE_GROUP" --yes --no-wait

echo "Cleanup started. Azure is deleting the resource group in the background."
