function Get-AzResourceGroups {
    [CmdletBinding()]
    param ()

    # Get all resource groups with their names, IDs, and locations
    $ResourceGroups = Get-AzResourceGroup | select-object ResourceGroupName, ResourceId, Location

    # Print the header message
    Write-Host "`n📌 This tenant have the following Resource Groups: " -ForegroundColor Yellow

    # Create an empty array to store the ResourceIds
    $resourceGroupNames = @()

    # Loop through each resource group and format the output
    $ResourceGroups | ForEach-Object {
        $resourceGroupName = $_.ResourceGroupName
        $resourceId = $_.ResourceId

        # Display the resource group info in green
        Write-Host "[+] Name: $resourceGroupName | ID: $resourceId" -ForegroundColor Green

        # Add the ResourceId to the array
        $resourceGroupNames += $resourceGroupName
    }

   
}
