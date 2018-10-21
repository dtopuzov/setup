#!/usr/bin/env bash

install_cli() {
    echo "Install {N} CLI."
    {
        npm uninstall -g -f nativescript
        npm install -g nativescript@latest --ignore-scripts
        tns usage-reporting disable
        tns error-reporting disable
        tns --version
    } &> "$HOME/logs/install-node-packages.log"
}

source $HOME/.bash_profile
install_cli
source $HOME/.bash_profile