param location string
param vnetProperties object


resource nsgLockdown 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: 'nsg-lockdown'
  location: location
}

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: 'vnet-on-premise'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetProperties.addressSpace
      ]
    }
    subnets: [
      {
        name: vnetProperties.subnets[0].name
        properties: {
          addressPrefix: vnetProperties.subnets[0].addressPrefix
          networkSecurityGroup: {
            id: nsgLockdown.id
          }
        }
      }
      {
        name: vnetProperties.subnets[0].name
        properties: {
          addressPrefix: vnetProperties.subnets[0].addressPrefix
          networkSecurityGroup: {
            id: nsgLockdown.id
          }
        }
      }      
    ]
  }
}
