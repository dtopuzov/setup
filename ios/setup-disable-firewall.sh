#!/usr/bin/env bash
# When run Appium tests with enabled macOS firewall you may see some popups in iOS Simulator.
# This script will exclude Xcode from firewall rules and should solve the problem.

# Temporarily shut firewall off:
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off

# Put Xcode as an exception:
/usr/libexec/ApplicationFirewall/socketfilterfw --add /Applications/Xcode.app/Contents/MacOS/Xcode

# Put iOS Simulator as an exception:
/usr/libexec/ApplicationFirewall/socketfilterfw --add /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator

# Re-enable firewall:
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
