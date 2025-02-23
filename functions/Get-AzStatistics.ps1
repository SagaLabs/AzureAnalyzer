<#
.SYNOPSIS
   This function returns a common list of statitics for an azure tenant

.DESCRIPTION
   This function returns a common list of statitics for an azure tenant
   Part of the Azure Analyzer

Gathers the following:

    Total amount of Resource Groups
    Total Subscriptions
    List all management groups if they are used
    Total amount of policies
    Total Administrative accounts
    Total amount of storage containers, public will be marked as red
    Total amount of VMs
    Total amount of OAuth applications
    Total amount of public IPs

.EXAMPLE
   An example of how to call the function
   For example:
     Get-AzStatistics

#>

function Get-AzStatistics {
    [CmdletBinding()]
    param ()

    Write-Host "`n📊 Gathering Azure Statistics..." -ForegroundColor Yellow

     # Count all resource groups
     $resourceGroups = Get-AzResourceGroup
     $resourceGroupCount = $resourceGroups.Count
     Write-Host "🔹 Total Resource Groups: $resourceGroupCount" -ForegroundColor Cyan

    # Count all subscriptions
    $subscriptions = Get-AzSubscription
    $subscriptionCount = $subscriptions.Count
    Write-Host "🔑 Total Subscriptions: $subscriptionCount" -ForegroundColor Cyan
    # Display Management group name
    try {
        $managementGroups = Get-AzManagementGroup
        if ($managementGroups) {
            Write-Host "🔹 Management Groups:" -ForegroundColor Cyan
            $managementGroups | ForEach-Object { Write-Host "   - $($_.DisplayName) ($($_.Name))" }
        } else {
            Write-Host "🔹 No Management Groups found." -ForegroundColor Cyan
        }
    } catch {
        Write-Host "⚠️ Unable to retrieve Management Groups. Ensure you have the right permissions." -ForegroundColor Yellow
    }
    # Count all policies
    $policies = Get-AzPolicyDefinition
    $policyCount = $policies.Count
    Write-Host "🔹 Total Policies: $policyCount" -ForegroundColor Cyan
        # Count all administrative accounts
    try {
        $adminRoles = @("Owner", "Contributor", "User Access Administrator", "Global Administrator", "Security Administrator")
        $allRoleAssignments = Get-AzRoleAssignment
        $adminAccounts = $allRoleAssignments | Where-Object { $_.RoleDefinitionName -in $adminRoles }
        $adminAccountCount = ($adminAccounts | Select-Object -Unique SignInName).Count
        Write-Host "🔹 Total Administrative Accounts: $adminAccountCount" -ForegroundColor Cyan
    } catch {
        Write-Host "⚠️ Unable to retrieve administrative accounts. Ensure you have the right permissions." -ForegroundColor Yellow
    }

    # Count all storage containers marked as public
    try {
        $storageAccounts = Get-AzStorageAccount
        $publicContainers = @()
        $totalContainers = 0

        foreach ($storage in $storageAccounts) {
            $context = $storage.Context
            $containers = Get-AzStorageContainer -Context $context
            $totalContainers += $containers.Count

            foreach ($container in $containers) {
                if ($container.PublicAccess -ne "None") {
                    $publicContainers += $container
                }
            }
        }
        Write-Host "🪣 Total Storage Containers: $totalContainers" -ForegroundColor Cyan

        $publicContainerCount = $publicContainers.Count
        

        if ($publicContainerCount -gt 0) {
            Write-Host "❌ Public Storage Containers Found: $publicContainerCount" -ForegroundColor Red
            $publicContainers | ForEach-Object { Write-Host "   - $($_.Name) in $($_.StorageAccountName)" -ForegroundColor Red }
        } else {
            Write-Host "✅ No public storage containers found." -ForegroundColor Green
        }
    } catch {
        Write-Host "⚠️ Unable to retrieve storage container information. Ensure you have the right permissions." -ForegroundColor Yellow
    }

    # Count total number of VMs
    $vmCount = (Get-AzVM).Count
    $runningVMs = (Get-AzVM | Where-Object { $_.PowerState -eq "VM running" }).Count
    Write-Host "💻 Total number of Virtual Machines: $vmCount" -ForegroundColor Cyan
    Write-Host "🔌 Total number of running VMs: $runningVMs" -ForegroundColor Cyan

    # Count total numbers of OAuth Apps
    $oauthAppCount = (Get-AzADApplication).Count
    Write-Host "🔹 Total number of OAuth Applications: $oauthAppCount" -ForegroundColor Cyan
    $servicePrincipalCount = (Get-AzADServicePrincipal).Count
    Write-Host "🔹 Total number of Service Principals: $servicePrincipalCount" -ForegroundColor Cyan

    # Count Public Ips
    $publicIPCount = (Get-AzPublicIpAddress).Count
    Write-Host "🔹 Total number of Public IPs: $publicIPCount" -ForegroundColor Cyan
    
    
}