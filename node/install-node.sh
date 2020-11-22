# Define Node version constant
export NODE_VERSION=14

reset_variables() {
  echo "Reset NodeJS variables."
  {
    if [[ "$OSTYPE" == "darwin"* ]]; then
      sed -i '' '/node@/d' $HOME/.bash_profile
      echo 'export PATH="/usr/local/opt/node@'$NODE_VERSION'/bin:$PATH"' >>~/.bash_profile
      source $HOME/.bash_profile
    else
      sed -i '/NPM_CONFIG_PREFIX/d' $HOME/.bash_profile
      sed -i '/npm-global/d' $HOME/.bash_profile
      echo 'export PATH='$HOME'/.npm-global/bin:$PATH' >>~/.bash_profile
      echo "NPM_CONFIG_PREFIX=$HOME/.npm-global" >>~/.bash_profile
    fi
  } &>"$HOME/logs/install-node.log"
}

install() {
  echo "Install NodeJS $NODE_VERSION."
  {
    if [[ "$OSTYPE" == "darwin"* ]]; then
      # clean old node installations
      sudo rm -rf /usr/local/{lib/node{,/.npm,_modules},bin,share/man}/{npm*,node*,man1/node*}
      sudo rm -rf '/usr/local/lib/dtrace/node.d'
      sudo rm -rf '/usr/local/etc/bash_completion.d/npm'
      sudo rm -rf '/usr/local/include/node'
      sudo rm -rf '/usr/local/lib/node_modules'
      rm -rf '$HOME/.npm'
      brew uninstall node -f
      brew uninstall node@$NODE_VERSION -f

      # install node
      brew install node@$NODE_VERSION -f
    else
      curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | sudo -E bash -
      sudo apt-get install -y nodejs
      mkdir ~/.npm-global
      npm config set prefix '~/.npm-global'
      source ~/.bash_profile
    fi

    source $HOME/.bash_profile
    node -v
    npm -v
  } &>"$HOME/logs/install-node.log"
}

reset_variables
source $HOME/.bash_profile

set +e
$(node -v | grep $NODE_VERSION. &>/dev/null)
EXIT_CODE=$?
set -e
if [ $EXIT_CODE == 0 ]; then
  echo "NodeJS $NODE_VERSION LTS found."
else
  install
fi
