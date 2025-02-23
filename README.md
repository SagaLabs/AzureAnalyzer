<div align="center">
<img src="./src/logo.png" style="max-width:30%">
<h1>
☁ Azure Log Analyzer
</h1>
<a href="/LICENSE"><img src="https://img.shields.io/badge/License-GPLv3-blue.svg?longCache=true&style=flat-square" alt="License"></a>
<br>
<img src="https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white"/>
<img src="https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white"/>
<p>
    The purpose of this suite is to be used to audit an Azure tenant for existing log configuration. 
</p>
</div>

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
Import-Module .\AzureLogAnalyzer.psm1
✅ AzureLogAnalyzer v1.0.0 loaded successfully! Use Get-Help AzureLogAnalyzer for usage.
[@] Developed by Christian Henriksen (Guzzy) - Learn more at https://github.com/SagaLabs/AzureLogAnalyzer
```

# Functions

### Show current role assignment in Entra ID
```powershell 
> Get-AzADRoles

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