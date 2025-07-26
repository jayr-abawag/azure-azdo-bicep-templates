@description('The name of the API Management service')
param name string

@description('The Azure region where the API Management service will be deployed')
param location string = resourceGroup().location

@description('The email address of the publisher/administrator')
param publisherEmail string

@description('The name of the publisher/administrator')
param publisherName string

@description('The pricing tier of the API Management service')
@allowed([
  'Consumption'
  'Developer'
  'Basic'
  'BasicV2'
  'Standard'
  'StandardV2'
  'Premium'
  'PremiumV2'])
param skuName string = 'Developer'

@description('The instance size of the API Management service')
param skuCapacity int = 1

@description('Enable system-assigned managed identity')
param enableSystemManagedIdentity bool = true

@description('Tags to apply to the API Management service')
param tags object = {}

@description('Enable Application Insights integration')
param enableApplicationInsights bool = false

@description('Application Insights resource ID (required if enableApplicationInsights is true)')
param applicationInsightsId string = ''

@description('Application Insights instrumentation key (required if enableApplicationInsights is true)')
param applicationInsightsInstrumentationKey string = ''

@description('Virtual network configuration')
param virtualNetworkConfiguration object = {}

@description('Custom domain configurations')
param customDomains array = []

@description('Certificate configurations for custom domains')
param certificates array = []

@description('Additional properties for the API Management service')
param additionalProperties object = {}

@description('Enable public network access')
param enablePublicNetworkAccess bool = true

@description('Minimum API version for the service')
param apiVersionConstraint string = ''

resource apimService 'Microsoft.ApiManagement/service@2024-06-01-preview' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: skuName
    capacity: skuCapacity
  }
  identity: enableSystemManagedIdentity ? {
    type: 'SystemAssigned'
  } : null
  properties: union({
    publisherEmail: publisherEmail
    publisherName: publisherName
    publicNetworkAccess: enablePublicNetworkAccess ? 'Enabled' : 'Disabled'
  }, !empty(virtualNetworkConfiguration) ? {
    virtualNetworkConfiguration: virtualNetworkConfiguration
  } : {}, !empty(customDomains) ? {
    hostnameConfigurations: customDomains
  } : {}, !empty(certificates) ? {
    certificates: certificates
  } : {}, enableApplicationInsights && !empty(applicationInsightsId) ? {
    diagnosticSettings: {
      name: 'ApplicationInsights'
      properties: {
        workspaceId: applicationInsightsId
        logs: [
          {
            category: 'GatewayLogs'
            enabled: true
          }
        ]
        metrics: [
          {
            category: 'AllMetrics'
            enabled: true
          }
        ]
      }
    }
  } : {}, !empty(apiVersionConstraint) ? {
    apiVersionConstraint: {
      minApiVersion: apiVersionConstraint
    }
  } : {}, additionalProperties)
}

// Application Insights Logger (if enabled)
resource apimLogger 'Microsoft.ApiManagement/service/loggers@2024-06-01-preview' = if (enableApplicationInsights && !empty(applicationInsightsId)) {
  parent: apimService
  name: 'applicationinsights'
  properties: {
    loggerType: 'applicationInsights'
    resourceId: applicationInsightsId
    credentials: {
      instrumentationKey: applicationInsightsInstrumentationKey
    }
  }
}

@description('The resource ID of the created API Management service')
output resourceId string = apimService.id

@description('The name of the created API Management service')
output name string = apimService.name

@description('The gateway URL of the API Management service')
output gatewayUrl string = apimService.properties.gatewayUrl

@description('The management API URL of the API Management service')
output managementApiUrl string = apimService.properties.managementApiUrl

@description('The developer portal URL of the API Management service')
output developerPortalUrl string = apimService.properties.developerPortalUrl

@description('The system-assigned managed identity principal ID (if enabled)')
output systemAssignedIdentityPrincipalId string = enableSystemManagedIdentity ? apimService.identity.principalId : ''

@description('The public IP addresses of the API Management service')
output publicIPAddresses array = apimService.properties.publicIPAddresses

// @description('The private IP addresses of the API Management service (if VNet integrated)')
// output privateIPAddresses array = apimService.properties.privateIPAddresses
