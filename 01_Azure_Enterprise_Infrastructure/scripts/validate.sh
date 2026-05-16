#!/usr/bin/env bash
set -euo pipefail

RESOURCE_GROUP="rg-enterprise-infra"

echo "Validating Azure Enterprise Cloud Platform resources..."

az group show --name "$RESOURCE_GROUP" --query "{name:name, location:location, state:properties.provisioningState}" -o table

echo "App Services:"
az webapp list --resource-group "$RESOURCE_GROUP" --query "[].{name:name, state:state, host:defaultHostName}" -o table

echo "Storage Accounts:"
az storage account list --resource-group "$RESOURCE_GROUP" --query "[].{name:name, sku:sku.name, accessTier:accessTier}" -o table

echo "Virtual Networks:"
az network vnet list --resource-group "$RESOURCE_GROUP" --query "[].{name:name, addressSpace:addressSpace.addressPrefixes[0]}" -o table

echo "Network Security Groups:"
az network nsg list --resource-group "$RESOURCE_GROUP" --query "[].{name:name, location:location}" -o table

echo "Key Vaults:"
az keyvault list --resource-group "$RESOURCE_GROUP" --query "[].{name:name, location:location}" -o table

echo "Metric Alerts:"
az monitor metrics alert list --resource-group "$RESOURCE_GROUP" --query "[].{name:name, enabled:enabled, severity:severity}" -o table

echo "Validation complete."
