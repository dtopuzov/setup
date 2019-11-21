#!/usr/bin/env bash

COCOAPODS_VERSION="1.8.4"

install_cocoapods() {
    set +e
    $(pod --version | grep $COCOAPODS_VERSION &> /dev/null)
    EXIT_CODE=$?
    set -e
    if [ $EXIT_CODE == 0 ]; then
        echo "pods@$COCOAPODS_VERSION found."
    else
        echo "Install pods@$COCOAPODS_VERSION"
        {
            sudo gem install cocoapods -v $COCOAPODS_VERSION

            set +e
            $(pod --version | grep $COCOAPODS_VERSION &> /dev/null)
            EXIT_CODE=$?
            set -e
            if [ $EXIT_CODE == 0 ]; then
                echo "Cocoa Pods installed."
            else
                echo "Failed to install Cocoa Pods!"
                exit 1
            fi
        } &> "$HOME/logs/install-pods.log"
    fi
}

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
install_cocoapods
source $HOME/.bash_profile
install_cli
source $HOME/.bash_profile