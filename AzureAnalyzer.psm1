# Import functions dynamically
Write-Host "[@] Developed by Christian Henriksen (Guzzy) - Learn more at https://github.com/SagaLabs/Azure Analyzer" -ForegroundColor Cyan
Write-Host "✅ Azure Analyzer v1.0.0 loaded successfully! Use Get-Help Azure Analyzer for usage." -ForegroundColor Green
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
Get-ChildItem -Path "$scriptPath/functions" -Filter *.ps1 | ForEach-Object { . $_.FullName }

  # Ensure user is logged in
  if (-not (Get-AzContext)) {
    Write-Host "🔹 Not logged in. Running Connect-AzAccount..." -ForegroundColor Yellow
    Connect-AzAccount
    }
    else {
        Write-Host "✅ Successfully connected to Azure" -ForegroundColor Green
    }

 # Ensure connected to Microsoft Graph
 try {
    Connect-MgGraph -Scopes "RoleManagement.Read.Directory", "User.Read.All" -NoWelcome
    Write-Host "✅ Successfully connected to Microsoft Graph" -ForegroundColor Green

} catch {
    Write-Host "❌ Failed to connect to Microsoft Graph. Ensure you have the correct permissions." -ForegroundColor Red
    return
}


# Export public functions
Export-ModuleMember -Function (Get-ChildItem -Path "$scriptPath/functions" -Filter *.ps1 | Select-Object -ExpandProperty BaseName)