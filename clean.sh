#!/usr/bin/env bash

create_logs_folder() {
    echo "Create log folder at $HOME/logs."
    {
        rm -rf $HOME/logs && mkdir -p $HOME/logs
    }
}

clean_workspace() {
    echo "Clean $HOME/workspace"
    {
        sudo rm -rf $HOME/workspace/*
    } &> "$HOME/logs/cleanup.log"
}

clean_xcode() {
    echo "Clean Xcode and iOS Simulator caches."
    {
        # Xcode caches
        sudo rm -rf /var/folders/* > /dev/null 2>&1 || true
        sudo rm -rf /Library/Caches/com.apple.dt.instruments/* || true
        sudo rm -rf ~/Library/Developer/Xcode/DerivedData/* || true
        sudo rm -rf ~/Library/Caches/CocoaPods/Pods/Release/* || true

        # Simulator logs
        rm -rf $HOME/Library/Logs/CoreSimulator/*

        # Unused SDKs
        sudo rm -rf /Library/Developer/CoreSimulator/Profiles/Runtimes/*8.*
        sudo rm -rf /Library/Developer/CoreSimulator/Profiles/Runtimes/*9.*
        sudo rm -rf /Library/Developer/CoreSimulator/Profiles/Runtimes/*10.*

    } &> "$HOME/logs/cleanup.log"
}

clean_gradle() {
    echo "Clean Gradle cache."
    {
        rm -rf ~/.gradle || true
    } &> "$HOME/logs/cleanup.log"
}

clean_android() {
    echo "Clean Android caches."
    {
        rm -rf ~/.android/build-cache/*
    } &> "$HOME/logs/cleanup.log"
}

clean_brew() {
    echo "y" | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)" || true
}

if [[ "$FORCE_CLEAN" == "true"* ]]; then
    echo "Full clean will be performed!"
    clean_workspace
    clean_brew
fi

clean_xcode
clean_gradle
clean_android

echo "Cleanup completed!"
