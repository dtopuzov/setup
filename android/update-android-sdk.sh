#!/usr/bin/env bash

source $HOME/.bash_profile
HAXM_PATH=$ANDROID_HOME/extras/intel/Hardware_Accelerated_Execution_Manager/silent_install.sh

update_intel_haxm() {
    echo "Update Intel HAXM."
    {
        print_and_execute "--licenses"
        print_and_execute "extras;intel;Hardware_Accelerated_Execution_Manager"

        chmod +x $HAXM_PATH
        INSTALLED_VERSION=$($HAXM_PATH -v)
        if [ $(echo $INSTALLED_VERSION | wc -c) -ge 2 ]; then
            echo "Intel HAXM $INSTALLED_VERSION is installed."
        else
            echo "Install Intel HAXM."
            sudo $HAXM_PATH
        fi
   } &> "$HOME/logs/update-android-sdk.log"
}

verify_intel_haxm() {
    chmod +x $HAXM_PATH
    if $HAXM_PATH -v | grep -q '.';
    then
        echo "Intel HAXM $($HAXM_PATH -v) found!"
    else
        echo "Intel HAXM NOT found!"
        exit 1
    fi
}

print_and_execute() {
    echo "sdkmanager $1" # print
    yes | $ANDROID_HOME/tools/bin/sdkmanager "$1" # execute
}

update_sdk() {
    echo "Update Android packages."
    {
        print_and_execute "--licenses"
        print_and_execute "platform-tools"
        print_and_execute "tools"
        print_and_execute "build-tools;29.0.0"
        print_and_execute "build-tools;28.0.3"
        print_and_execute "platforms;android-28"
        print_and_execute "platforms;android-27"
        print_and_execute "platforms;android-26"
        print_and_execute "platforms;android-25"
        print_and_execute "platforms;android-24"
        print_and_execute "platforms;android-23"
        print_and_execute "platforms;android-22"
        print_and_execute "platforms;android-21"
        print_and_execute "platforms;android-19"
        print_and_execute "emulator"
        print_and_execute "extras;android;m2repository"
        print_and_execute "extras;google;m2repository"
    } &> $HOME/logs/update-android-sdk.logs
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    update_intel_haxm
    verify_intel_haxm
fi
update_sdk