#!/usr/bin/env bash

# Notes:
# Android SDK needs JDK 1.8.
# See:
# https://stackoverflow.com/questions/53076422/getting-android-sdkmanager-to-run-with-java-11
# https://medium.com/@parsher/flutter-android-sdkmanager-update-with-jdk-12-ad8098165472

verify_android_home() {
  android=$(echo $ANDROID_HOME)
  if [[ $android != "" ]]; then
    echo "ANDROID_HOME is set to: $android"
  else
    echo "ANDROID_HOME is empty!"
    exit 1
  fi
}

reset_variables() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Reset ANDROID SDK variables."
    {
      # Remove old ANDROID variables.
      sed -i '' '/ANDROID_HOME/d' $HOME/.bash_profile
      sed -i '' '/ANDROID_SDK_ROOT/d' $HOME/.bash_profile

      # Add ANDROID variables.
      echo "Add ANDROID_HOME variable."
      echo 'export ANDROID_HOME=/usr/local/share/android-sdk' >>$HOME/.bash_profile
      echo 'export ANDROID_SDK_ROOT=/usr/local/share/android-sdk' >>$HOME/.bash_profile

      # reaload .bash_profile
      source $HOME/.bash_profile
    } &>$HOME/logs/install-android-sdk.log
  else
    echo "Not implemented!"
    exit 1
  fi
}

install() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Install Android SDK."
    {
      # Uninstall old ANDROID SDKs.
      brew uninstall android-sdk -f
      brew cask uninstall android-sdk -f
      rm -rf $HOME/.android
      mkdir -p $HOME/.android
      touch $HOME/.android/repositories.cfg

      # Install new ANDROID SDKs.
      echo "Install Android SDK."
      brew install --cask android-sdk
    } &>$HOME/logs/install-android-sdk.log
  else
    echo "Not implemented!"
    exit 1
  fi
}

source $HOME/.bash_profile

# Reset variables
reset_variables

# Install Android SDK only if not available.
source $HOME/.bash_profile
if [[ -f $ANDROID_HOME/tools/bin/sdkmanager ]]; then
  echo "Android SDK found."
else
  install
  source $HOME/.bash_profile
  verify_android_home
fi

# Accept Android SDK licenses
source $HOME/.bash_profile

if test -f "$ANDROID_HOME/tools/bin/sdkmanager"; then
    echo "Accept Android SDK licenses."
    yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses &> $HOME/logs/install-android-sdk.log
else
  echo "Failed to install Android SDK!"
  exit 1
fi
