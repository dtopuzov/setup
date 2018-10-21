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
if [[ $(mvn -version) =~ "3." ]]; then
    echo "Maven 3 found.";
else
    install
fi
