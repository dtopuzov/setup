#!/usr/bin/env bash

source $HOME/.bash_profile

download() {
  echo "$ANDROID_HOME/tools/bin/sdkmanager "$1""
  yes | $ANDROID_HOME/tools/bin/sdkmanager "$1"
}

configure_avd() {
  echo "Configure Android emulators."
  {
    echo "Clean settings of $HOME/.android/avd/$1.avd/config.ini"
    sed -i '' '/hw./d' $HOME/.android/avd/$1.avd/config.ini
    sed -i '' '/vm./d' $HOME/.android/avd/$1.avd/config.ini
    sed -i '' '/disk./d' $HOME/.android/avd/$1.avd/config.ini

    echo "Add $dir/config/$2/config.ini to $HOME/.android/avd/$1.avd/config.ini"
    cat "$dir/config/$2/config.ini" >>$HOME/.android/avd/$1.avd/config.ini
  } &>$HOME/logs/configure-android-emulator-$1.logs
}

update_images() {
  echo "Update Android emulator images."
  {
    download "--licenses"
    download "system-images;android-30;google_apis_playstore;x86"
    download "system-images;android-29;google_apis_playstore;x86"
    download "system-images;android-28;google_apis_playstore;x86"
    download "system-images;android-27;google_apis_playstore;x86"
    download "system-images;android-26;google_apis_playstore;x86"
    download "system-images;android-25;google_apis_playstore;x86"
    download "system-images;android-24;google_apis_playstore;x86"
    download "system-images;android-23;google_apis;x86"
  } &>$HOME/logs/update-android-emulator-images.logs
}

create() {
  echo "Create Emulators"
  {
    echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n "Nexus5Api23" -k "system-images;android-23;google_apis;x86" -b "google_apis/x86" -c "256M" -f
    echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n "Nexus5XApi24" -k "system-images;android-24;google_apis_playstore;x86" -b "google_apis_playstore/x86" -c "256M" -f
    echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n "Nexus5XApi25" -k "system-images;android-25;google_apis_playstore;x86" -b "google_apis_playstore/x86" -c "256M" -f
    echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n "Nexus6PApi26" -k "system-images;android-26;google_apis_playstore;x86" -b "google_apis_playstore/x86" -c "256M" -f
    echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n "PixelApi27" -k "system-images;android-27;google_apis_playstore;x86" -b "google_apis_playstore/x86" -c "256M" -f
    echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n "Pixel2Api28" -k "system-images;android-28;google_apis_playstore;x86" -b "google_apis_playstore/x86" -c "256M" -f
    echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n "Pixel3Api29" -k "system-images;android-29;google_apis_playstore;x86" -b "google_apis_playstore/x86" -c "256M" -f
    echo no | $ANDROID_HOME/tools/bin/avdmanager create avd -n "Pixel4Api30" -k "system-images;android-30;google_apis_playstore;x86" -b "google_apis_playstore/x86" -c "256M" -f
  } &>$HOME/logs/create-android-emulators.logs
}

configure() {
  echo "Configure Emulators"
  {
    configure_avd "Nexus5Api23" "Nexus5"
    configure_avd "Nexus5XApi24" "Nexus5X"
    configure_avd "Nexus5XApi25" "Nexus5X"
    configure_avd "Nexus6PApi26" "Nexus6P"
    configure_avd "PixelApi27" "Pixel"
    configure_avd "Pixel2Api28" "Pixel2"
    configure_avd "Pixel3Api29" "Pixel3"
    configure_avd "Pixel4Api30" "Pixel4"
  } &>$HOME/logs/configure-android-emulators.logs
}

dir="$(dirname "$0")"

update_images
create
configure

source $HOME/.bash_profile
