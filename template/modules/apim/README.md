# API Management Simple Module

This Bicep module creates an Azure API Management service with basic configuration and optional availability zone support.

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `apiManagementServiceName` | string | `apiservice{uniqueString}` | The name of the API Management service instance |
| `publisherEmail` | string | *required* | The email address of the service owner |
| `publisherName` | string | *required* | The name of the service owner |
| `sku` | string | `Developer` | The pricing tier (Developer, Standard, Premium) |
| `skuCount` | int | `1` | The instance size of the service |
| `location` | string | `resourceGroup().location` | Location for all resources |
| `availabilityZones` | array | `["1", "2", "3"]` | Availability zones for deployment |

## Outputs

| Output | Type | Description |
|--------|------|-------------|
| `apiManagementServiceName` | string | The name of the API Management service |
| `apiManagementResourceId` | string | The resource ID of the API Management service |
| `gatewayUrl` | string | The gateway URL of the API Management service |
| `portalUrl` | string | The portal URL of the API Management service |
| `managementApiUrl` | string | The management API URL |
| `developerPortalUrl` | string | The developer portal URL |

## Features

- ✅ System-assigned managed identity enabled
- ✅ Availability zone support (configurable)
- ✅ Configurable SKU and capacity
- ✅ Multiple output endpoints for integration

## Usage

```bicep
module apim 'path/to/main.bicep' = {
  name: 'apimDeployment'
  params: {
    apiManagementServiceName: 'my-apim-service'
    publisherEmail: 'admin@company.com'
    publisherName: 'My Company'
    sku: 'Developer'
    location: 'East US'
  }
}
```

## Example Deployment

```bash
az deployment group create \
  --resource-group myResourceGroup \
  --template-file main.bicep \
  --parameters @parameters.json
```
