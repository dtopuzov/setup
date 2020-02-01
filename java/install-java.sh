#!/usr/bin/env bash

########################################################
#
# This script will install Open JDK 1.8,11 and 13.
# Default in .bash_profile will be `Open JDK 1.8`.
#
########################################################
# shellcheck disable=SC1090
# shellcheck disable=SC2181

source "$HOME"/.bash_profile

# Reset variables
sed -i '' '/JAVA_HOME/d' "$HOME"/.bash_profile
echo "export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)" >>"$HOME"/.bash_profile

# Install JDKs
declare -a arr=("1.8" "11" "13")
for i in "${arr[@]}"; do
  RESULT=$(/usr/libexec/java_home -v 13 2>&1)
  echo "$RESULT" | grep 'Unable to find' &>/dev/null
  if [ $? == 0 ]; then
    echo "Install Open JDK $i."
    {
      # Handle Java 1.8 is acutally installed with adoptopenjdk8
      if [[ "$i" == "1.8" ]]; then
        "$i" = "8"
      fi

      brew tap adoptopenjdk/openjdk
      brew cask install adoptopenjdk"$i" -f
      brew untap adoptopenjdk/openjdk
    } &>"$HOME"/logs/install-java"$i".logs
  else
    echo "JDK $i found."
  fi
done

source "$HOME"/.bash_profile
