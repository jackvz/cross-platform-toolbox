pkg update

# pkg install -y nano python3 py3-pip node npm git wget curl # chromium pycharm-ce intellij vscode
pkg install -y nano python27 node npm git wget curl # linux-c7 linux_base-c7 chromium pycharm-ce intellij vscode
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py && sudo python2.7 get-pip.py && rm get-pip.py

# @todo:
# pkg install -y bash
# chsh -s bash
# bash

pkg install -y consul
