#!/usr/bin/env bash

source $HOME/.bash_profile

if [[ "$OSTYPE" == "darwin"* ]]; then
  brew cask uninstall intellij-idea-ce
  sudo rm -rf /Applications/IntelliJ*
  brew install --cask intellij-idea-ce
else
  sudo snap remove intellij-idea-community
  sudo snap install intellij-idea-community --classic
fi
