#!/bin/bash
set -e

echo "🚀 Installing GUI development tools using winget..."

/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -Command "
\$packages = @(
    'Microsoft.VisualStudioCode'
)

foreach (\$package in \$packages) {
    if (winget list --id \$package | Select-String \$package) {
        Write-Host '✅' \$package 'is already installed. Skipping...'
    } else {
        Write-Host '🔧 Installing' \$package '...'
        winget install --id=\$package -e --source winget
        if (\$LASTEXITCODE -ne 0) {
            Write-Host '⚠️ Error installing' \$package ', but continuing setup...'
        } else {
            Write-Host '✅' \$package 'installed successfully.'
        }
    }
}
"

echo "✅ GUI development tools installation complete"
