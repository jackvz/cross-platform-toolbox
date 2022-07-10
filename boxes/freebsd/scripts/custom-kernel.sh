sudo rm -rf /boot/kernel.old
sudo mv /boot/kernel /boot/kernel.old
sudo mkdir /boot/kernel
sudo cp /tmp/custom-kernel.zip /boot/kernel
cd /boot/kernel
sudo unzip custom-kernel.zip
sudo rm custom-kernel.zip
