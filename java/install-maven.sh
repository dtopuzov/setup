#!/usr/bin/env bash

source $HOME/.bash_profile

install() {
  echo "Install Maven."
  {
    brew uninstall maven -f
    brew install maven
    mvn -v
  } &>"$HOME/logs/install-maven.log"
}

set +e
$(mvn -version 2>/dev/null | grep 3 >/dev/null 2>&1)
EXIT_CODE=$?
set -e
if [ $EXIT_CODE == 0 ]; then
  echo "Maven 3 found."
else
  install
fi
