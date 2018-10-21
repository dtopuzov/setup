#!/usr/bin/env bash

source $HOME/.bash_profile

configure() {
    echo "Configure Android emulators."
    {
        # Append "hw.gpu.enabled=yes", "hw.lcd.density=240" and "skin.name=480x800" to config.ini file of each emulator
        find ~/.android/avd -type f -name 'config.ini' -exec bash -c 'echo $0 && echo "hw.lcd.density=240" | tee -a $0 && echo "skin.name=480x800" | tee -a $0 && echo "hw.gpu.enabled=yes"  | tee -a $0 && echo "hw.keyboard=no" | tee -a $0 && cat $0 '  {} \;
        find ~/.android/avd/Emulator-Api23-Default.avd -type f -name 'config.ini' -exec bash -c 'echo $0 && echo "disk.dataPartition.size=4048MB" | tee -a $0 && echo "hw.ramSize=2048" | tee -a $0 && cat $0' {} \;
        find ~/.android/avd/Emulator-Api19-Default.avd -type f -name 'config.ini' -exec bash -c 'echo $0 && echo "hw.ramSize=1024" | tee -a $0 && cat $0' {} \;
        find ~/.android/avd/Emulator-Api19-Google.avd -type f -name 'config.ini' -exec bash -c 'echo $0 && echo "hw.ramSize=1024" | tee -a $0 && cat $0' {} \;
        find ~/.android/avd/Emulator-Api26-Default.avd -type f -name 'config.ini' -exec bash -c 'echo $0 && echo "hw.gps=yes" | tee -a $0 && cat $0' {} \;
        find ~/.android/avd/Emulator-Api26-Playground.avd -type f -name 'config.ini' -exec bash -c 'echo $0 && echo "hw.gps=yes" | tee -a $0 && echo "hw.mainKeys=no" | tee -a $0 && cat $0' {} \;
    } &> $HOME/logs/update-android-emulators.logs
}

verify() {
    existing_emulators=$($ANDROID_HOME/tools/emulator -list-avds)
    array=(Emulator-Api17-Default Emulator-Api18-Default Emulator-Api17-Default Emulator-Api21-Default Emulator-Api22-Default Emulator-Api23-Default Emulator-Api24-Default Emulator-Api25-Google Emulator-Api26-Google Emulator-Api27-Google Emulator-Api28-Google)
    for emu in "${array[@]}"
    do
        if [[ ! $existing_emulators =~ $emu ]]; then
            echo "Emulator NOT found: " $emu;
            exit 1
        fi
    done
}

print_and_execute() {
    echo "sdkmanager $1" # print
    yes | $ANDROID_HOME/tools/bin/sdkmanager "$1" # execute
}

update_images() {
    echo "Update Android emulator images."
    {
        print_and_execute "system-images;android-23;default;x86"
        print_and_execute "system-images;android-22;default;x86"
        print_and_execute "system-images;android-21;default;x86"
        print_and_execute "system-images;android-19;default;x86"
    } &> $HOME/logs/update-android-emulators.logs
}

create() {
    echo "Create Emulators"
    {
        echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n Emulator-Api19-Default -k "system-images;android-19;default;x86" -b default/x86 -c 900M -f
        echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n Emulator-Api21-Default -k "system-images;android-21;default;x86" -b default/x86 -c 900M -f
        echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n Emulator-Api22-Default -k "system-images;android-22;default;x86" -b default/x86 -c 900M -f
        echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n Emulator-Api23-Default -k "system-images;android-23;default;x86" -b default/x86 -c 2048M -f
    } &> $HOME/logs/update-android-emulators.logs
}

update_images

API23_AVD_PATH=$HOME/.android/avd/Emulator-Api23-Default.avd/config.ini
if [ ! -f $API23_AVD_PATH ]; then
    create
else
    # Do not create emulators if emulators are created in last week.
    if test `find "$API23_AVD_PATH" -mmin +20160`
    then
        create
    else
        echo "Brand new emulators detected."
        echo "Skip emulator creation."
    fi
fi


# verify
configure

source $HOME/.bash_profile