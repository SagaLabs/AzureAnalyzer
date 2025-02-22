# Import functions dynamically
Write-Host "✅ AzureLogAnalyzer v1.0.0 loaded successfully! Use Get-Help AzureLogAnalyzer for usage." -ForegroundColor Green
Write-Host "[@] Developed by Christian Henriksen (Guzzy) - Learn more at https://github.com/SagaLabs/AzureLogAnalyzer" -ForegroundColor Cyan
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
Get-ChildItem -Path "$scriptPath/functions" -Filter *.ps1 | ForEach-Object { . $_.FullName }


# Export public functions
Export-ModuleMember -Function (Get-ChildItem -Path "$scriptPath/functions" -Filter *.ps1 | Select-Object -ExpandProperty BaseName)