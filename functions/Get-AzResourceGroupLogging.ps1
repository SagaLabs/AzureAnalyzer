function Get-AzResourceGroupLogging {
    [CmdletBinding()]
    param ()
    
    # Retrieve all resource groups
    $resourceGroups = Get-AzResourceGroup
    Write-Host "`n📌 Checking Diagnostic Settings " -ForegroundColor Yellow

    # Loop through each resource group
    $resourceGroups | ForEach-Object {
        $resourceGroupName = $_.ResourceGroupName
        #Write-Host "Processing Resource Group: $resourceGroupName" -ForegroundColor Green
        
        # Get all resources within the resource group
        $resources = Get-AzResource -ResourceGroupName $resourceGroupName
        #$resources | Format-Table Name, Type, ResourceGroup, Location, ResourceId
        
        # Loop through each resource to get diagnostic settings
        $resources | ForEach-Object {
            $ResourceId = $_.ResourceId.ToString()  # Ensure ResourceId is a string
            
            # Check if the resource type supports diagnostic settings
            if ($_.'Type' -in @(
                "Microsoft.Compute/virtualMachines",
                "Microsoft.Network/networkInterfaces",
                "Microsoft.Network/publicIPAddresses",
                "Microsoft.Storage/storageAccounts",
                "Microsoft.Web/sites",
                "Microsoft.Sql/servers",
                "Microsoft.ContainerInstance/containerGroups",
                "Microsoft.EventHub/namespaces",
                "Microsoft.EventGrid/topics"
                # Add other supported resource types here
            )) {
                # Get diagnostic settings for supported resources
                $diagnosticSettings = Get-AzDiagnosticSetting -ResourceId $ResourceId

                # Print the diagnostic settings if available
                if ($diagnosticSettings) {
                    Write-Host "✅ Diagnostic settings for Resource '$($ResourceId)':" -ForegroundColor Cyan
                    $diagnosticSettings | Format-Table Name, Id, Enabled, Logs, Metrics, MarketplacePartnerId, LogAnalyticsDestinationType, WorkspaceId, EventHubName, StorageAccountId
                }
                else {
                    Write-Host "❌ No diagnostic settings found for Resource '$($ResourceId)'" -ForegroundColor Red
                }
            } 
        }
    }
}
