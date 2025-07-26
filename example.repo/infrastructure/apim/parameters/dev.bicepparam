using '../main.bicep'

param name = 'jra-eus-dev-apim-service'
param location = 'East US'
param publisherEmail = 'jayr.abawag@3cloudsolutions.com'
param publisherName = 'POC DevOps Team'
param skuName = 'Developer'
param skuCapacity = 1
param enableSystemManagedIdentity = true
param enableApplicationInsights = false
param enablePublicNetworkAccess = true
param tags = {
  environment: 'development'
  project: 'POC'
  costCenter: 'IIG-Dev'
  owner: 'POC DevOps'
}
