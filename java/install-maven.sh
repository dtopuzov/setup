#!/usr/bin/env bash

source $HOME/.bash_profile

install() {
    echo "Install Maven."
    {
        brew uninstall maven -f
        brew install maven
        mvn -v
    } &> "$HOME/logs/install-maven.log"
}

# check if maven@3 is installed
RESULT=$(mvn -version -v 13 2>&1)
echo $RESULT | grep '3.0' &> /dev/null
if [ $? == 0 ]; then
    install
else
    echo "Maven 3 found."
fi
