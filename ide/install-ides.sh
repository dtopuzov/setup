#!/usr/bin/env bash

source $HOME/.bash_profile

brew cask uninstall visual-studio-code -f
brew cask uninstall pycharm-ce -f
brew cask uninstall intellij-idea-ce -f

sudo rm -rf /Applications/IntelliJ*
sudo rm -rf /Applications/PyCharm*
sudo rm -rf /Applications/Visual\ Studio\ Code.app

brew cask install visual-studio-code
brew cask install pycharm-ce
brew cask install intellij-idea-ce
