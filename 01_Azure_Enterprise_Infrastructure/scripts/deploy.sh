#!/usr/bin/env bash
set -euo pipefail

RESOURCE_GROUP="rg-enterprise-infra"
LOCATION="eastus"
VNET_NAME="vnet-enterprise"
SUBNET_NAME="app-subnet"
NSG_NAME="nsg-enterprise"
STORAGE_ACCOUNT="stenterprisefiles$RANDOM"
APP_SERVICE_PLAN="asp-rgenterpriseinfra-free"
WEB_APP_NAME="enterprise-app-demo-$RANDOM"
KEY_VAULT_NAME="kv-enterprise-$RANDOM"
PROJECT_CONTAINER="project-files"
LOGS_CONTAINER="logs"

echo "Starting Azure Enterprise Cloud Platform deployment..."

az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

az network vnet create   --resource-group "$RESOURCE_GROUP"   --location "$LOCATION"   --name "$VNET_NAME"   --address-prefix "10.0.0.0/16"   --subnet-name "$SUBNET_NAME"   --subnet-prefix "10.0.0.0/24"

az network nsg create   --resource-group "$RESOURCE_GROUP"   --location "$LOCATION"   --name "$NSG_NAME"

az network nsg rule create   --resource-group "$RESOURCE_GROUP"   --nsg-name "$NSG_NAME"   --name "allow-http"   --priority 100   --direction Inbound   --access Allow   --protocol Tcp   --source-address-prefixes "*"   --source-port-ranges "*"   --destination-address-prefixes "*"   --destination-port-ranges 80

az network nsg rule create   --resource-group "$RESOURCE_GROUP"   --nsg-name "$NSG_NAME"   --name "allow-https"   --priority 110   --direction Inbound   --access Allow   --protocol Tcp   --source-address-prefixes "*"   --source-port-ranges "*"   --destination-address-prefixes "*"   --destination-port-ranges 443

az network vnet subnet update   --resource-group "$RESOURCE_GROUP"   --vnet-name "$VNET_NAME"   --name "$SUBNET_NAME"   --network-security-group "$NSG_NAME"

az storage account create   --name "$STORAGE_ACCOUNT"   --resource-group "$RESOURCE_GROUP"   --location "$LOCATION"   --sku Standard_LRS   --kind StorageV2   --access-tier Hot   --min-tls-version TLS1_2   --allow-blob-public-access false

az storage container create --name "$PROJECT_CONTAINER" --account-name "$STORAGE_ACCOUNT" --auth-mode login
az storage container create --name "$LOGS_CONTAINER" --account-name "$STORAGE_ACCOUNT" --auth-mode login

az appservice plan create   --name "$APP_SERVICE_PLAN"   --resource-group "$RESOURCE_GROUP"   --location "$LOCATION"   --is-linux   --sku F1

az webapp create   --resource-group "$RESOURCE_GROUP"   --plan "$APP_SERVICE_PLAN"   --name "$WEB_APP_NAME"   --runtime "NODE:22-lts"

az keyvault create   --name "$KEY_VAULT_NAME"   --resource-group "$RESOURCE_GROUP"   --location "$LOCATION"   --enable-rbac-authorization true   --retention-days 90

az keyvault secret set   --vault-name "$KEY_VAULT_NAME"   --name "db-password"   --value "PortfolioDemoPassword!2026"

WEB_APP_ID=$(az webapp show --name "$WEB_APP_NAME" --resource-group "$RESOURCE_GROUP" --query id -o tsv)

az monitor metrics alert create   --name "enterprise-app-high-request-alert"   --resource-group "$RESOURCE_GROUP"   --scopes "$WEB_APP_ID"   --condition "total Requests > 5"   --window-size 5m   --evaluation-frequency 5m   --description "Alert when total web app requests are greater than 5 in a 5-minute window."

echo "Deployment complete."
echo "Web app URL: https://$(az webapp show --name "$WEB_APP_NAME" --resource-group "$RESOURCE_GROUP" --query defaultHostName -o tsv)"
