#!/usr/bin/env bash

reset_variables() {
    echo "Reset NodeJS variables."
    {
        sed -i '' '/node@/d' $HOME/.bash_profile
        echo 'export PATH="/usr/local/opt/node@10/bin:$PATH"' >> ~/.bash_profile
        source $HOME/.bash_profile
    } &> "$HOME/logs/install-node.log"
}

install() {
    echo "Install NodeJS."
    {
        # clean old node installations
        sudo rm -rf /usr/local/{lib/node{,/.npm,_modules},bin,share/man}/{npm*,node*,man1/node*}
        sudo rm -rf '/usr/local/lib/dtrace/node.d'
        sudo rm -rf '/usr/local/etc/bash_completion.d/npm'
        sudo rm -rf '/usr/local/include/node'
        sudo rm -rf '/usr/local/lib/node_modules'
        rm -rf '$HOME/.npm'
        brew uninstall --force node
        brew uninstall --force node@8
        brew uninstall --force node@10

        # install node
        brew install node@12 -f

        source $HOME/.bash_profile
        node -v
        npm -v
    } &> "$HOME/logs/install-node.log"
}

reset_variables
source $HOME/.bash_profile

set +e
$(node -v | grep 12. &> /dev/null)
EXIT_CODE=$?
set -e
if [ $EXIT_CODE == 0 ]; then
    echo "NodeJS 12 LTS found."
else
    install
fi