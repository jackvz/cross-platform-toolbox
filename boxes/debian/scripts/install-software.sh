apt update
# apt -yq install wget curl python3 python3-pip nodejs npm git # nano build-essential chromium
apt -yq install wget curl python2.7 nodejs npm git # nano build-essential chromium
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py && python2 get-pip.py && rm get-pip.py

apt -yq install consul
