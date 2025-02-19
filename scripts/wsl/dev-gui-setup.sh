#!/bin/bash
set -e

echo "🚀 Installing GUI development tools using winget..."

packages="
Microsoft.VisualStudioCode
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

echo "✅ GUI development tools installation complete"
