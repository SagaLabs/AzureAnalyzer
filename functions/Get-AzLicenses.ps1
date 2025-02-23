<#
.SYNOPSIS
   This function returns a table of users and their associated licenses

.DESCRIPTION
   This function returns a table of users and their associated licenses
   Part of the Azure Analyzer
.EXAMPLE
   An example of how to call the function
   For example:
     Get-AzLicenses

#>

function Get-AzLicenses {
    [CmdletBinding()]
    param ()
    Write-Host "`n📊 Gathering Licenses..." -ForegroundColor Yellow
    # Display licenses
    Get-MgUser | ForEach-Object {
        $userLicenses = Get-MgUserLicenseDetail -UserId $_.Id
        $displayName = $_.DisplayName
        $userName = $_.UserPrincipalName
        $userLicenses | ForEach-Object {
            [PSCustomObject]@{
                DisplayName  = $displayName
                UserName     = $userName
                LicenseSku   = $_.SkuPartNumber
            }
        }
    } | Format-Table DisplayName, UserName, LicenseSku
    
}