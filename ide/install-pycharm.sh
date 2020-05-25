#!/usr/bin/env bash

source $HOME/.bash_profile

brew cask uninstall pycharm-ce -f
sudo rm -rf /Applications/PyCharm*
brew cask install pycharm-ce
