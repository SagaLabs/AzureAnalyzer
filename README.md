<div align="center">

<h1>
☁ Azure Analyzer
</h1>
<a href="/LICENSE"><img src="https://img.shields.io/badge/License-GPLv3-blue.svg?longCache=true&style=flat-square" alt="License"></a>
<br>
<img src="https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white"/>
<img src="https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white"/>
<p style="text-align:left">
    Azure Analyzer is a PowerShell tool designed to help you audit and analyze your Azure tenant. It provides a set of functions to for example quickly gather key data on resource groups, subscriptions, roles, policies, virtual machines, OAuth apps, and more. You can use it to check logging configurations, track administrative accounts, and identify security concerns like public storage containers. It’s a simple but powerful way to monitor and maintain your Azure environment.
</p>
</div>

---

# Features

### Feature

- [X] Verify permissions.
- [X] Identify public storage accounts.
- [X] Gather basic statistics about tenant.
- [x] Query and list assigned licenses.
- [x] Count the number of resource groups in the tenant.
- [x] Determine the number of active subscriptions.
- [ ] Retrieve and display all global administrators.
- [X] Identify which logs are enabled in the tenant's diagnostic settings.
- [ ] List the top five most expensive resources.
- [X] List amount of running VMs.
- [ ] Identify accounts with MFA disabled.
- [ ] Check Azure Policy compliance status.
- [ ] Review consent settings for enterprise applications.
- [X] Display list of non-OAuth & OAuth applications.
- [ ] Display owners or contributors for all resource groups.
- [ ] List all administrative accounts.
- [ ] Identify public IPs and their associated resources.
- [ ] Additional storage-related queries.
- [ ] Display Tenant trust
- [ ] O365/SharePoint File sharing settings.
- [ ] Check if Unified Audit log is enabled.


---

# Getting started

## Prerequisites

- PowerShell

**The follwing PowerShell modules:**
- Microsoft.Graph
- Az.Resources
- Az.Accounts

### Install PowerShell Modules
```powershell
Install-Module Az.Resources -Force
Install-Module Az.Accounts -Force
Install-Module Microsoft.Graph -Scope CurrentUser
```

## Installation
To start using the utility simply git clone the repo and run <br>
```powershell
> Import-Module .\AzureAnalyzer.psm1
✅ Azure Analyzer v1.0.0 loaded successfully! 
[@] Developed by Christian Henriksen (Guzzy) - Learn more at https://github.com/SagaLabs/AzureAnalyzer
```

# Functions

### List all available functions

```powershell
> Get-Command -Module AzureLogAnalyzer
```

### Show current role assignment in Entra ID
```powershell 
> Get-AzEntraIDRoles

🔹 Logged in as: John Doe (UUID)

📌 Your Azure Entra ID Directory Roles:
 - Global Administrator (GUID)
 - Global Secure Access Administrator (GUID)
```

### Show RBAC Permissions along with Entra ID role assignment.
```powershell
> Get-AzPermissions
🔹 Logged in as: john@doe.com

📌 Your Azure RBAC Role Assignments (Resource Permissions):

DisplayName         RoleDefinitionName        Scope
-----------         ------------------        -----
John Doe Owner                     /subscriptions/string
John Doe Key Vault Administrator   /subscriptions/string/resourceGroups/RGName/providers/Microsoft.KeyVault/vaults/vaultname
John Doe User Access Administrator /
John Doe Owner                     /providers/Microsoft.Management/managementGroups/string

🔹 Logged in as: John Doe (UUID)

📌 Your Azure Entra ID Directory Roles:
 - Global Administrator (GUID)
 - Global Secure Access Administrator (GUID)
```

### Show All Resource Groups
```powershell
> Get-AzResourceGroups

📌 This tenant have the following Resource Groups:
[+] Name: SagaLabs-Test-Container | ID: /subscriptions/string/resourceGroups/RGName
[+] Name: Test-RG-Name | ID: /subscriptions/string/resourceGroups/RGName

```

### Show Resource Level Logging
*note that this also logs to a log file called diagnosticsettings.csv in the output folder*
```powershell
> Get-AzResourceGroupLogging
```

### Show statistics of tenant
**Gathers the following:**
- Total amount of Resource Groups
- Total Subscriptions
- List all management groups if they are used
- Total amount of policies
- Total Administrative accounts
- Total amount of storage containers, public will be marked as red
- Total amount of VMs
- Total amount of OAuth applications
- Total amount of public IPs

```powershell
> Get-AzStatistics

📊 Gathering Azure Statistics...
🔹 Total Resource Groups: 21
🔑 Total Subscriptions: 3
🔹 Management Groups:
   - Tenant Root Group (ID)
🔹 Total Policies: 3505
🔹 Total Administrative Accounts: 6
🔹 Total Storage Containers: 5
❌ Public Storage Containers Found: 5
   - azure-webjobs-hosts in
   - test in
   - test1 in
   - test2 in
   - cool-test in
💻 Total number of Virtual Machines: 9
🔌 Total number of running VMs: 0
🔹 Total number of OAuth Applications: 11
🔹 Total number of Service Principals: 514
🔹 Total number of Public IPs: 4

```


### Show all licenses in the tenant

```powershell
> Get-AzLicenses
```

### Show Applications
*Shows both non-OAuth applications and OAuth*
```powershell
> Get-AzApplicationInfo
```


# Contribute
This tool has been made as a simple audit tool, and we would like some feedback on it. Please use discussions or issues for submitting feature requests. 
