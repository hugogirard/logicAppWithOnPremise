targetScope='subscription'

param location string

// @secure()
// param adminUsername string

// @secure()
// param adminPassword string

var spokeOnPremiseName = 'rg-spoke-on-premise'

var vnetSpokeOnPremise = {
  addressSpace: '10.0.0.0/16'
  subnets: [
    {
      name: 'snet-fileserver'
      addressPrefix: '10.0.1.0/24'
    }
    {
      name: 'snet-gateway'
      addressPrefix: '10.0.2.0/24'
    }    
  ]
}

resource spokeOnPremiseRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: spokeOnPremiseName
  location: location
}

module vnetOnPremise 'modules/network/vnet.premise.bicep' = {
  scope: resourceGroup(spokeOnPremiseRg.name)
  name: 'vnetOnPremise'
  params: {
    location: location
    vnetProperties: vnetSpokeOnPremise
  }
}

