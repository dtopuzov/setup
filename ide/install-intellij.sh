#!/usr/bin/env bash

source $HOME/.bash_profile

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew cask uninstall intellij-idea-ce -f
    sudo rm -rf /Applications/IntelliJ*
    brew cask install intellij-idea-ce
else
    sudo snap remove pycharm-community
    sudo snap install pycharm-community --classic
fi
