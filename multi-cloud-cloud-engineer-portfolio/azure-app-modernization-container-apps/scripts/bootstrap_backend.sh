#!/usr/bin/env bash
set -euo pipefail

LOCATION="eastus"
RG="rg-tfstate-jamie"
SA="sttfstatejamie"
CONTAINER="tfstate"

az group create -n "$RG" -l "$LOCATION"
az storage account create -g "$RG" -n "$SA" -l "$LOCATION" --sku Standard_LRS
KEY=$(az storage account keys list -g "$RG" -n "$SA" --query "[0].value" -o tsv)
az storage container create --name "$CONTAINER" --account-name "$SA" --account-key "$KEY"

echo "Azure Terraform backend created:"
echo "  Resource Group: $RG"
echo "  Storage Account: $SA"
echo "  Container: $CONTAINER"
