// @allowed(['dev', 'uat', 'prd'])
// param environment string
@description('Name of the resources')
param name string 

@description('Location for all resources')
param location string

@description('The email address of the API Management publisher')
param publisherEmail string

@description('The name of the API Management publisher')
param publisherName string

@description('The pricing tier of this API Management service')
@allowed([
  'Developer'
  'Standard'
  'Premium'
])
param skuName string = 'Developer'

@description('The instance size of this API Management service')
param skuCapacity int = 1

@description('Enable system managed identity')
param enableSystemManagedIdentity bool = false

@description('Enable Application Insights')
param enableApplicationInsights bool = false

@description('Enable public network access')
param enablePublicNetworkAccess bool = true

@description('Tags to be applied to the API Management service')
param tags object = {}             
module apim '../../devops/modules/apim/main.bicep' = {
  name: 'apiManagementDeployment'
  params: {
    name: name
    location: location
    publisherEmail: publisherEmail
    publisherName: publisherName
    skuName: skuName
    skuCapacity: skuCapacity
    enableApplicationInsights: enableApplicationInsights
    enablePublicNetworkAccess: enablePublicNetworkAccess
    enableSystemManagedIdentity: enableSystemManagedIdentity
    tags: tags
  }
}

// Outputs
@description('The name of the created API Management service')
output apiManagementServiceName string = apim.outputs.name

@description('The resource ID of the API Management service')
output apiManagementResourceId string = apim.outputs.resourceId

@description('The gateway URL of the API Management service')
output gatewayUrl string = apim.outputs.gatewayUrl

@description('The portal URL of the API Management service')
output portalUrl string = apim.outputs.developerPortalUrl

@description('The management API URL')
output managementApiUrl string = apim.outputs.managementApiUrl

@description('The developer portal URL')
output developerPortalUrl string = apim.outputs.developerPortalUrl
