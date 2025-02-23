function Get-AzResourceGroupLogging {
    [CmdletBinding()]
    param ()

    # Define the output folder and log file path
    $outputFolder = ".\output"
    $logFilePath = "$outputFolder\diagnosticsetting.csv"

    # Create the output folder if it doesn't exist
    if (-not (Test-Path -Path $outputFolder)) {
        New-Item -Path $outputFolder -ItemType Directory
    }

    # If the log file exists, remove it, so we start fresh
    if (Test-Path -Path $logFilePath) {
        Remove-Item -Path $logFilePath
    }

    # Create a header for the CSV file
    $header = "ResourceId,ResourceType,DiagnosticSettingStatus"
    Add-Content -Path $logFilePath -Value $header

    # Retrieve all resource groups
    $resourceGroups = Get-AzResourceGroup
    Write-Host "`n📌 Checking Diagnostic Settings " -ForegroundColor Yellow

    # Loop through each resource group
    $resourceGroups | ForEach-Object {
        $resourceGroupName = $_.ResourceGroupName
        
        # Get all resources within the resource group
        $resources = Get-AzResource -ResourceGroupName $resourceGroupName
        
        # Loop through each resource to get diagnostic settings
        $resources | ForEach-Object {
            $ResourceId = $_.ResourceId.ToString()  # Ensure ResourceId is a string
            $resourceType = $_.'Type'
            
            # Check if the resource type supports diagnostic settings
            if ($resourceType -in @(
                "Microsoft.Compute/virtualMachines",
                "Microsoft.Network/networkInterfaces",
                "Microsoft.Network/publicIPAddresses",
                "Microsoft.Storage/storageAccounts",
                "Microsoft.Web/sites",
                "Microsoft.Sql/servers",
                "Microsoft.ContainerInstance/containerGroups",
                "Microsoft.EventHub/namespaces",
                "Microsoft.EventGrid/topics"
            )) {
                # Get diagnostic settings for supported resources
                $diagnosticSettings = Get-AzDiagnosticSetting -ResourceId $ResourceId

                # Check if diagnostic settings are found
                if ($diagnosticSettings) {
                    Write-Host "✅ Diagnostic settings for Resource '$($ResourceId)'" -ForegroundColor Cyan
                    # Log to CSV (ResourceId, ResourceType, DiagnosticSettingStatus)
                    $logMessage = "$ResourceId,$resourceType,Enabled"
                    Add-Content -Path $logFilePath -Value $logMessage
                }
                else {
                    Write-Host "❌ No diagnostic settings found for Resource '$($ResourceId)'" -ForegroundColor Red
                    # Log to CSV (ResourceId, ResourceType, DiagnosticSettingStatus)
                    $logMessage = "$ResourceId,$resourceType,Not Enabled"
                    Add-Content -Path $logFilePath -Value $logMessage
                }
            } else {
                Write-Host "⚠️ Resource type '$($resourceType)' does not support diagnostic settings for Resource '$($ResourceId)'" -ForegroundColor Yellow
                # Log to CSV (ResourceId, ResourceType, DiagnosticSettingStatus)
                $logMessage = "$ResourceId,$resourceType,Not Supported"
                Add-Content -Path $logFilePath -Value $logMessage
            }
        }
    }
}
