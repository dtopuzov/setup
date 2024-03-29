#!/usr/bin/env bash

export DOTNET_VERSION=6.0

install() {
  echo "Install .NET Core SDK $DOTNET_VERSION."
  {
    if [[ "$OSTYPE" == "darwin"* ]]; then
      brew install --cask dotnet-sdk
      brew install mono-libgdiplus
    else
      # Add Microsoft registry
      wget -q https://packages.microsoft.com/config/ubuntu/19.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
      sudo dpkg -i packages-microsoft-prod.deb

      # Install .NET Core SDK
      sudo apt-get update
      sudo apt-get install apt-transport-https
      sudo apt-get update
      sudo apt-get install dotnet-sdk-$DOTNET_VERSION

      # Install deps for System.Drawing
      sudo apt-get install libc6-dev
      sudo apt-get install libgdiplus
    fi

    # Verify installed
    dotnet --version
  } &>"$HOME/logs/install-dotnet.log"
}

set +e
$(dotnet --version | grep $DOTNET_VERSION >/dev/null 2>&1)
EXIT_CODE=$?
set -e
if [ $EXIT_CODE == 0 ]; then
  echo ".NET Core SdK $DOTNET_VERSION found."
else
  install
fi
