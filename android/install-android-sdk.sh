#!/usr/bin/env bash

verify_android_home() {
	android=$(echo $ANDROID_HOME)
	if [[ $android != "" ]]; then
		echo "ANDROID_HOME is set to: $android"
	else
		echo "ANDROID_HOME is empty!"
		exit 1
	fi
}

reset_variables() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Reset ANDROID SDK variables."
        {
            # Remove old ANDROID variables.
            sed -i '' '/ANDROID_HOME/d' $HOME/.bash_profile
            sed -i '' '/ANDROID_SDK_ROOT/d' $HOME/.bash_profile

            # Add ANDROID variables.
            echo "Add ANDROID_HOME variable."
            echo 'export ANDROID_HOME=/usr/local/share/android-sdk' >> $HOME/.bash_profile
            echo 'export ANDROID_SDK_ROOT=/usr/local/share/android-sdk' >> $HOME/.bash_profile
            echo 'export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools/bin' >> $HOME/.bash_profile

            # reaload .bash_profile
            source $HOME/.bash_profile
        } &> $HOME/logs/install-android-sdk.log
    else
        echo "Not implemented!"
        exit 1
    fi
}

install() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Install Android SDK."
        {
            # Uninstall old ANDROID SDKs.
            brew uninstall android-sdk -f
            brew cask uninstall android-sdk -f
            rm -rf $HOME/.android
            mkdir -p $HOME/.android
            touch $HOME/.android/repositories.cfg

            # Install new ANDROID SDKs.
            echo "Install Android SDK."
            brew cask install android-sdk
        } &> $HOME/logs/install-android-sdk.log
    else
        echo "Not implemented!"
        exit 1
    fi
}

# Reset variables
reset_variables

# Install Android SDK only if not available.
source $HOME/.bash_profile
if [[ -f $ANDROID_HOME/tools/bin/sdkmanager ]]; then
    echo "Android SDK found."
else
    install
    source $HOME/.bash_profile
    verify_android_home
fi

# Accept Android SDK licenses
echo "Accept Android SDK licenses."
yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses &> $HOME/logs/install-android-sdk.log
