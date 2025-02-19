#!/bin/bash
set -e

echo "🚀 Installing general applications using winget..."

packages="
Google.Chrome
Notion.Notion
Discord.Discord
Zoom.Zoom
DeepL.DeepL
Yubico.Authenticator
AutoHotkey.AutoHotkey
Microsoft.PowerToys
KeePassXCTeam.KeePassXC
Anysphere.Cursor
Microsoft.VisualStudioCode
Microsoft.WindowsTerminal
Microsoft.PowerShell
"

for package in $packages; do
    if winget.exe list --id $package | grep -q $package; then
        echo "✅ $package is already installed. Skipping..."
    else
        echo "🔧 Installing $package ..."
        winget.exe install --id=$package -e --source winget
        if [ $? -ne 0 ]; then
            echo "⚠️ Error installing $package , but continuing setup..."
        else
            echo "✅ $package installed successfully."
        fi
    fi
done

echo "✅ General applications installation complete"
