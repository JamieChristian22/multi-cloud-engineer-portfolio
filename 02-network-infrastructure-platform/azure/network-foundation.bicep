param location string = resourceGroup().location

resource vnet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: 'vnet-enterprise-network'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'public-subnet'
        properties: {
          addressPrefix: '10.20.1.0/24'
        }
      }
      {
        name: 'private-subnet'
        properties: {
          addressPrefix: '10.20.2.0/24'
        }
      }
    ]
  }
}

output vnetName string = vnet.name
