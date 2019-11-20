#!/usr/bin/env bash

source $HOME/.bash_profile

TESSERACT_VERSION="4.1"

install_tesseract() {
    set +e
    $(tesseract --version | grep $TESSERACT_VERSION &> /dev/null)
    EXIT_CODE=$?
    set -e
    if [ $EXIT_CODE == 0 ]; then
        echo "tesseract@$TESSERACT_VERSION found."
    else
        echo "Install tesseract@$TESSERACT_VERSION"
        {
            brew uninstall --ignore-dependencies tesseract -f
            brew install tesseract

            set +e
            $(tesseract --version | grep $TESSERACT_VERSION &> /dev/null)
            EXIT_CODE=$?
            set -e
            if [ $EXIT_CODE == 0 ]; then
                echo "tesseract installed."
            else
                echo "Failed to install tesseract!"
                exit 1
            fi
        } &> "$HOME/logs/install-tesseract.log"
    fi
}

install_tesseract