#!/usr/bin/env bash

source $HOME/.bash_profile

if [[ "$OSTYPE" == "darwin"* ]]; then
  brew uninstall intellij-idea-ce -f
  sudo rm -rf /Applications/IntelliJ*
  brew install intellij-idea-ce
else
  sudo snap remove intellij-idea-community
  sudo snap install intellij-idea-community --classic
fi
