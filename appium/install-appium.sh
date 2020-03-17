#!/usr/bin/env bash

source $HOME/.bash_profile
APPIUM_VERSION="1.17.0"

install_ios_deps() {
  echo "Install Appium dependencies for iOS."
  {
    brew uninstall --ignore-dependencies libimobiledevice -f
    brew uninstall --ignore-dependencies ideviceinstaller -f
    brew uninstall --ignore-dependencies carthage -f
    brew install libimobiledevice
    brew install ideviceinstaller
    brew install carthage

    carthage help | grep bootstrap

    set +e
    $(carthage help | grep bootstrap &>/dev/null)
    EXIT_CODE=$?
    set -e
    if [ $EXIT_CODE == 0 ]; then
      echo "Carthage installed."
    else
      echo "Failed to carthage!"
      exit 1
    fi
  } &>"$HOME/logs/install-appium.log"
}

# ios-deploy is used in tests
install_ios_deploy() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Install ios-deploy."
    {
      set +e
      $(ios-deploy --version | grep 2. &>/dev/null)
      EXIT_CODE=$?
      set -e
      if [ $EXIT_CODE == 0 ]; then
        echo "ios-deploy found."
      else
        npm uninstall -g -f ios-deploy
        brew uninstall --ignore-dependencies ios-deploy -f
        brew install ios-deploy
        ios-deploy --version
      fi
    } &>"$HOME/logs/install-node-packages.log"
  fi
}

install_appium() {
  echo "Install Appium."
  {
    npm un -g appium -f || true
    npm i -g appium@$APPIUM_VERSION
    appium -v
  } &>"$HOME/logs/install-appium.log"
}

set +e
$(appium -v 2>/dev/null | grep $APPIUM_VERSION >/dev/null 2>&1)
EXIT_CODE=$?
set -e
if [ $EXIT_CODE == 0 ]; then
  echo "Appium@$APPIUM_VERSION found."
else
  if [[ "$OSTYPE" == "darwin"* ]]; then
    install_ios_deps
    install_ios_deploy
  fi
  install_appium
fi
