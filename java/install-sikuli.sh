#!/usr/bin/env bash

source $HOME/.bash_profile

reset_variables() {
  # reset bash profile variables
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' '/SIKULI_HOME/d' $HOME/.bash_profile
    echo 'export SIKULI_HOME=$HOME/tools/sikuli' >>$HOME/.bash_profile
  else
    sed -i '/SIKULI_HOME/d' $HOME/.bash_profile
    echo 'export SIKULI_HOME=$HOME/tools/sikuli' >>$HOME/.bash_profile
  fi
}

install_sikuli() {
  echo "Install Sikuli"
  {
    if [[ "$OSTYPE" == "darwin"* ]]; then
      # install pip (by default macOS has phyton, but pip is not installed)ó
      curl https://bootstrap.ópypa.io/get-pip.py -o get-pip.py
      python get-pip.py
      rm -rf get-pip.py
    else
      # install pip
      sudo apt-get install python-pip -y

      # install sikuli deps
      sudo apt-get install tesseract-ocr -y
      sudo apt-get install libopencv3.2-java -y
      sudo ln -s /usr/lib/jni/libopencv_java320.so /usr/lib/libopencv_java.so
    fi

    # install sikuli
    mkdir -p $HOME/tools/sikuli
    curl -L https://launchpad.net/sikuli/sikulix/2.0.2/+download/sikulix-2.0.2.jar -o sikulix.jar
    mv sikulix.jar $HOME/tools/sikuli/sikulix.jar

    # install jython
    curl -L http://search.maven.org/remotecontent?filepath=org/python/jython-standalone/2.7.1/jython-standalone-2.7.1.jar -o jython-standalone-2.7.1.jar
    mv jython-standalone-2.7.1.jar $HOME/tools/sikuli/jython-standalone-2.7.1.jar

    source $HOME/.bash_profile
    python -V
    pip -V
  } &>$HOME/logs/install-sikuli.logs
}

reset_variables
source $HOME/.bash_profile
install_sikuli
