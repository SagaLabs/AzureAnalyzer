<#
.SYNOPSIS
   This function returns the EntraID roles associated with the current context user.

.DESCRIPTION
   This function returns the EntraID roles associated with the current context user.
   Part of the Azure Analyzer
.EXAMPLE
   An example of how to call the function
   For example:
     Get-AzEntraIDRoles

#>
function Get-AzEntraIDRoles {
    [CmdletBinding()]
    param ()

    # Get current user
    $User = Get-MgUser -UserId (Get-AzContext).Account.Id
    Write-Host "🔹 Logged in as: $($User.DisplayName) ($($User.Id))" -ForegroundColor Cyan

    # Get Azure AD role assignments
    $roles = Get-MgRoleManagementDirectoryRoleAssignment -Filter "PrincipalId eq '$($User.Id)'"
    
    if ($roles) {
        Write-Host "`n📌 Your Azure Entra ID Directory Roles:" -ForegroundColor Yellow
        
        # Retrieve all role definitions
        $roleDefinitions = Get-MgRoleManagementDirectoryRoleDefinition
        
        foreach ($role in $roles) {
            # Match the RoleDefinitionId from the assignment
            $roleDef = $roleDefinitions | Where-Object { $_.Id -eq $role.RoleDefinitionId }
            
            if ($roleDef) {
                Write-Host " - $($roleDef.DisplayName) ($($roleDef.Id))" -ForegroundColor Green
            } else {
                Write-Host "❌ Unable to retrieve role definition for RoleDefinitionId: $($role.RoleDefinitionId)" -ForegroundColor Red
            }
        }
    } else {
        Write-Host "❌ No Azure Entra ID roles assigned to this account." -ForegroundColor Red
    }
}
