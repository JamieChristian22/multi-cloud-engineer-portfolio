param location string = resourceGroup().location

resource vault 'Microsoft.RecoveryServices/vaults@2023-04-01' = {
  name: 'rsv-enterprise-backup'
  location: location
  sku: { name: 'Standard' }
  properties: { publicNetworkAccess: 'Enabled' }
}

output vaultName string = vault.name
