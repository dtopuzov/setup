#!/usr/bin/env bash

source $HOME/.bash_profile

if [[ "$OSTYPE" == "darwin"* ]]; then
  brew cask uninstall pycharm-ce
  sudo rm -rf /Applications/PyCharm*
  brew cask install pycharm-ce
else
  sudo snap remove pycharm-community
  sudo snap install pycharm-community --classic
fi
