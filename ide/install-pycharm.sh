#!/usr/bin/env bash

source $HOME/.bash_profile

if [[ "$OSTYPE" == "darwin"* ]]; then
    brew cask uninstall pycharm-ce -f
    sudo rm -rf /Applications/PyCharm*
    brew cask install pycharm-ce
else
    sudo snap remove code
    sudo snap install --classic code
fi
