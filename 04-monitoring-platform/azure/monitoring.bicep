param location string = resourceGroup().location
param emailAddress string

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: 'law-enterprise-monitoring'
  location: location
  properties: { sku: { name: 'PerGB2018' } retentionInDays: 30 }
}

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: 'ag-enterprise-alerts'
  location: 'global'
  properties: {
    groupShortName: 'entalert'
    enabled: true
    emailReceivers: [
      { name: 'primary-email' emailAddress: emailAddress useCommonAlertSchema: true }
    ]
  }
}
