#!/usr/bin/env bash

source $HOME/.bash_profile

if [[ "$OSTYPE" == "darwin"* ]]; then
  brew uninstall pycharm-ce -f
  sudo rm -rf /Applications/PyCharm*
  brew install --cask pycharm-ce
else
  sudo snap remove pycharm-community
  sudo snap install pycharm-community --classic
fi
