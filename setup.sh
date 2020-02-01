#!/usr/bin/env bash

create_logs_folder() {
    echo "Create log folder at $HOME/logs."
    {
        rm -rf $HOME/logs && mkdir -p $HOME/logs
    }
}

enable_sudo_without_password() {
    USER=$(whoami)
    CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1 | grep "load" | wc -l)
    if [ ${CAN_I_RUN_SUDO} -gt 0 ]
    then
        echo "$USER can run commands with sudo without password."
    else
        echo "Enable $USER to run commands with sudo without password."
        if [ $(echo ${PASS} | wc -c) -ge 3 ]; then
            echo "PASS variable is set!"
        else
            echo "PASS variable is NOT set!"
            exit 1
        fi

        USER=$(whoami)
        echo ${PASS} | sudo -kS bash -c 'echo "'${USER}' ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)' &> /dev/null

        sudo cat /etc/sudoers &> /dev/null
        if [ $? == 0 ]; then
            echo "$USER can run commands with sudo without password.";
        else
            echo "Failed to enable $USER to run commands with sudo without password."
            exit 1
        fi
    fi
}

clean_bash_profile() {
    echo "Generate ~/.bash_profile."
    rm -rf $HOME/.bash_profile
    echo "" > $HOME/.bash_profile

    if [ ! -f $HOME/.personal_profile ]; then
        echo "Personal profile not found, will use default."
        cp "$dir/.personal_profile" $HOME/.personal_profile
    fi
    source $HOME/.personal_profile

    cat $HOME/.personal_profile >> $HOME/.bash_profile
    echo "" >> $HOME/.bash_profile
    echo "#####################################################################" >> $HOME/.bash_profile
    echo "#                       Auto Generated Settings                     #" >> $HOME/.bash_profile
    echo "#####################################################################" >> $HOME/.bash_profile
    echo "" >> $HOME/.bash_profile

    source $HOME/.bash_profile
}

enable_developer_mode() {
    echo "Enable developer mode."
    sudo /usr/sbin/DevToolsSecurity --enable &> "$HOME/logs/enable-developer-mode.log"
}

install_brew() {
    set +e
    $(brew -v 2> /dev/null | grep Homebrew > /dev/null 2>&1)
    EXIT_CODE=$?
    set -e
    if [ ${EXIT_CODE} == 0 ]; then
        echo "Update Homebrew";
        {
            brew update
        } &> "$HOME/logs/update-brew.log"
    else
        echo "Install Homebrew."
        {
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
            brew -v
            brew update
        } &> "$HOME/logs/install-brew.log"
    fi

    # Ensure xcode is selected (sometime it get fucked up by installing brew)
    if [ -d /Applications/Xcode.app/Contents/Developer ]; then
        sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
    else
        if [ -d /Applications/Xcode-beta.app/Contents/Developer ]; then
            sudo xcode-select -s /Applications/Xcode-beta.app/Contents/Developer
        else
            echo "Xcode not installed in /Application folder!"
            exit 1
        fi
    fi
}

set -e
dir="$(dirname "$0")"

# log environment variables
echo ""
echo "#####################################################################"
echo "#                       Environment Variables                       #"
echo "#####################################################################"
echo ""

printenv

# start setup
echo ""
echo "#####################################################################"
echo "#                       Setup Machine Script                        #"
echo "#####################################################################"
echo ""

enable_sudo_without_password

# check xcode (required manual installation).
if [[ $(xcodebuild -version) =~ "Xcode" ]]; then
    echo "Xcode found!";
else
    echo "Xcode NOT found! Please install it manually."
    exit 1
fi

create_logs_folder
clean_bash_profile
enable_developer_mode
install_brew

"$dir/java/install-java.sh"
"$dir/java/install-maven.sh"

"$dir/android/install-android-sdk.sh"
"$dir/android/update-android-sdk.sh"
"$dir/android/update-android-emulators.sh"

"$dir/node/install-node.sh"
"$dir/appium/install-appium.sh"

echo "Setup completed!"
