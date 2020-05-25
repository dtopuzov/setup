#!/usr/bin/env bash

source $HOME/.bash_profile

brew cask uninstall intellij-idea-ce -f
sudo rm -rf /Applications/IntelliJ*
brew cask install intellij-idea-ce
