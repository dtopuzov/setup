#!/bin/bash

install_telnet() {
  brew install telnet -f
}

kill_emulators() {
    echo "Kill all emulators."
    ps aux | grep qemu | grep -v grep | awk '{print $2}' | xargs kill -9 >/dev/null 2>&1 || true
    sleep 5
}

clean_snapshots() {
    echo "Delete snapshots."
    for EMU in "${EMULATORS_ARRAY[@]}"
    do  
        SNAPSHOTS_FOLDER="$HOME/.android/avd/$EMU.avd/snapshots"
        find $SNAPSHOTS_FOLDER ! -path $SNAPSHOTS_FOLDER -maxdepth 1 -type d ! -name '*default*' | xargs rm -rf >/dev/null 2>&1
        find $SNAPSHOTS_FOLDER ! -path $SNAPSHOTS_FOLDER -maxdepth 1 -type d ! -name '*clean*' | xargs rm -rf >/dev/null 2>&1
    done
}

take_snapshots() {
    for EMU in "${EMULATORS_ARRAY[@]}"
    do  
        # boot
        echo "Take snapshot for $EMU."
        $ANDROID_HOME/emulator/emulator -avd $EMU -wipe-data -no-boot-anim -no-audio -no-snapshot-load & >/dev/null 2>&1
        until $ANDROID_HOME/platform-tools/adb -s emulator-5554 shell dumpsys window | grep -E 'mFocusedApp' | grep -q 'ActivityRecord' >/dev/null 2>&1;
        do
            echo "Wait $EMU to boot..."
            sleep 5
        done
        sleep 30
        echo "$EMU booted!"

        # take snapshot
        echo "Take snapshot of $EMU"
        { echo "auth $(cat $HOME/.emulator_console_auth_token)"; echo "avd snapshot save clean"; sleep 30; } | telnet localhost 5554 >/dev/null 2>&1

        # kill
        kill_emulators

        # verify snapshot is created
        if [ ! -f $HOME/.android/avd/$EMU.avd/snapshots/clean/ram.bin ]; then
            echo "Failed to take snapshot of $EMU!"
            exit 1
        else
            echo "Snapshot created!"
        fi
    done
}

EMULATORS_ARRAY=($($ANDROID_HOME/emulator/emulator -list-avds))

install_telnet
kill_emulators
clean_snapshots
take_snapshots
