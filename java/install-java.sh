#!/usr/bin/env bash

########################################################
#
# This script will install Open JDK 1.8, 11 and 13.
# Default in .bash_profile will be `Open JDK 1.8`.
#
########################################################
# shellcheck disable=SC1090
# shellcheck disable=SC2140
# shellcheck disable=SC2181

source "$HOME"/.bash_profile

# Install JDKs
declare -a arr=("1.8" "11" "15")
for i in "${arr[@]}"; do
  set +e
  VERSION=$(echo $i | cut -d '.' -f2)
  $(/usr/libexec/java_home -v "$i" 2>/dev/null | grep $VERSION >/dev/null 2>&1)
  EXIT_CODE=$?
  set -e

  if [ $EXIT_CODE == 0 ]; then
    echo "Open JDK $i found."
  else
    echo "Install Open JDK $VERSION."
    {
      brew tap adoptopenjdk/openjdk
      brew install --cask adoptopenjdk"$VERSION"
    } &>"$HOME"/logs/install-java.logs
  fi
done

# Reset variables
echo "Set JAVA_HOME in ~/.bash_profile (use JDK 1.8)."
{
  sed -i '' '/JAVA_HOME/d' "$HOME"/.bash_profile
  echo "export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)" >> "$HOME"/.bash_profile
  source "$HOME"/.bash_profile
} &>"$HOME"/logs/install-java.logs
