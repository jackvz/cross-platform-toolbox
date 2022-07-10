sudo dnf update -y
sudo dnf install -y python2 nodejs git # g++ gcc-c++ make clang chromium
sudo yum install -y pip

sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install consul
