########################################################
#
# This script will install:
# - Open JDK 1.8
# - Open JDK 12
# Default in .bash_profile will be `Open JDK 1.8`.
#
########################################################

#!/usr/bin/env bash

source $HOME/.bash_profile

reset_variables() {
    # reset bash profile variables
    sed -i '' '/JAVA_HOME/d' $HOME/.bash_profile
    echo 'export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)' >> $HOME/.bash_profile
}

install_java8() {
    echo "Install Open JDK 8."
    {
        brew tap adoptopenjdk/openjdk
        brew cask install adoptopenjdk8
        source $HOME/.bash_profile
        java -version
        brew untap adoptopenjdk/openjdk
    } &> $HOME/logs/install-java.logs
}

install_java12() {
    echo "Install Open JDK 12."
    {
        brew tap caskroom/versions
        brew cask uninstall java -f
        brew cask install java
        source $HOME/.bash_profile
        java -version
    } &> $HOME/logs/install-java.logs
}

reset_variables
source $HOME/.bash_profile

# Install Java 8
JAVA_VERSION=$($JAVA_HOME/bin/java -version 2>&1)
echo $JAVA_VERSION | grep 'openjdk version' | grep '1.8' &> /dev/null
if [ $? == 0 ]; then
    echo "JDK 8 found."
else
    install_java8
fi

# Install Java 11
RESULT=$(/usr/libexec/java_home -v 12 2>&1)
echo $RESULT | grep 'Unable to find' &> /dev/null
if [ $? == 0 ]; then
    install_java12
else
    echo "JDK 12 found."
fi