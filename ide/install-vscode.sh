#!/usr/bin/env bash

source $HOME/.bash_profile

# Uninstall & Install
if [[ "$OSTYPE" == "darwin"* ]]; then
  brew cask uninstall visual-studio-code
  sudo rm -rf /Applications/Visual\ Studio\ Code.app
  rm -rf /usr/local/bin/code
  rm -rf ~/.vscode/extensions
  brew cask install visual-studio-code
else
  sudo snap remove code
  sudo snap install --classic code
fi

# Install Extensions
code --install-extension christian-kohler.npm-intellisense
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension DotJoshJohnson.xml
code --install-extension amodio.gitlens
code --install-extension eg2.vscode-npm-script
code --install-extension elsnoman.packsharp
code --install-extension formulahendry.dotnet-test-explorer
code --install-extension Fudge.auto-using
code --install-extension jmrog.vscode-nuget-package-manager
code --install-extension ms-dotnettools.csharp
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension vscode-icons-team.vscode-icons
code --install-extension streetsidesoftware.code-spell-checker
