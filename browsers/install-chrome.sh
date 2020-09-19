#!/usr/bin/env bash

echo "Install Google Chrome" {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Install Chrome not implemented on macOS"
    else
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome*.deb
        sudo apt-get install -f
        sudo apt autoremove
	rm -rf *.deb
    fi
} &>"$HOME"/logs/install-chrome.logs
