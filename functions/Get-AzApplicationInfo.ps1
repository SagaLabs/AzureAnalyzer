function Get-AzApplicationInfo {
    [CmdletBinding()]
    param ()

    Write-Host "`n📊 Gathering Applications..." -ForegroundColor Yellow
    
    Get-MgApplication | 
    Format-Table DisplayName, AppId, SignInAudience, PublisherDomain -AutoSize

    Write-Host "`n📊 Gathering OAuth Applications..." -ForegroundColor Yellow

    Get-MgOauth2PermissionGrant | Format-Table ClientId, ConsentType, PrincipalId


}