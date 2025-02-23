<#
.SYNOPSIS
   This function returns non-OAuth and OAuth applications in the tenant

.DESCRIPTION
   This function returns non-OAuth and OAuth applications in the tenant
   Part of the AzureLogAnalyzer
.EXAMPLE
   An example of how to call the function
   For example:
     Get-AzApplicationInfo

#>
function Get-AzApplicationInfo {
    [CmdletBinding()]
    param ()

    Write-Host "`n📊 Gathering Applications..." -ForegroundColor Yellow
    # Display non-OAuth application
    Get-MgApplication | 
    Format-Table DisplayName, AppId, SignInAudience, PublisherDomain -AutoSize

    Write-Host "`n📊 Gathering OAuth Applications..." -ForegroundColor Yellow
    # Display OAuth application
    Get-MgOauth2PermissionGrant | Format-Table ClientId, ConsentType, PrincipalId


}