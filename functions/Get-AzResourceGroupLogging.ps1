function Get-AzResourceGroupLogging {
    [CmdletBinding()]
    param ()
    # Call the function and save the returned ResourceIds into a variable
    $resourceIds = Get-AzResourceGroups
    Write-Host "`n📌 Checking Diagnostic Settings " -ForegroundColor Yellow

    # Use the $resourceIds array for further processing
    $resourceIds | ForEach-Object {
        Write-Host "Processing Resource ID: $_"
        $diagnosticSettings = Get-AzDiagnosticSetting -ResourceId $_

        # Print the diagnostic settings
        if ($diagnosticSettings) {
            Write-Host "Diagnostic settings for Resource Group '$_':" -ForegroundColor Cyan
            $diagnosticSettings | Format-Table Name, Enabled, Logs, Metrics
        }
        else {
            Write-Host "No diagnostic settings found for Resource Group '$_'" -ForegroundColor Red
        }
    }

}