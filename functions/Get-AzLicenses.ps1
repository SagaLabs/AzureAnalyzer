function Get-AzLicenses {
    [CmdletBinding()]
    param ()
    Write-Host "`n📊 Gathering Azure Licenses..." -ForegroundColor Yellow

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