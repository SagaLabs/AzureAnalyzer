<#
.SYNOPSIS
   This function returns current Azure RBAC role assignments for the current context user. 

.DESCRIPTION
   This function returns current Azure RBAC role assignments for the current context user. 
   Part of the Azure Analyzer
.EXAMPLE
   An example of how to call the function
   For example:
     Get-AzPermissions

#>
function Get-AzPermissions {
    [CmdletBinding()]
    param ()

  

    # Get current user
    $User = (Get-AzContext).Account
    Write-Host "🔹 Logged in as: $($User.Id)" -ForegroundColor Cyan

    # Get Azure RBAC Role Assignments
    Write-Host "`n📌 Your Azure RBAC Role Assignments (Resource Permissions):" -ForegroundColor Yellow
    $rbacRoles = Get-AzRoleAssignment -SignInName $User.Id | Select-Object DisplayName, RoleDefinitionName, Scope
    if ($rbacRoles) {
        $rbacRoles | Format-Table -AutoSize
    } else {
        Write-Host "❌ No Azure RBAC roles found for this account." -ForegroundColor Red
    }

    # Get Azure AD Roles using Microsoft Graph
    Get-AzEntraIDRoles
}
