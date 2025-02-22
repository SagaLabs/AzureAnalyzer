<div align="center">
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

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
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