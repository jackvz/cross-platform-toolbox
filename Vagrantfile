ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|
  config.vm.define "windows-2019" do |config|
    config.vm.box = "jackvanzyl/windows-2019"
    config.vm.box_version = "0.1.0"
    config.vm.provider "virtualbox" do |v|
      v.gui = true
      v.name = "Windows"
      v.check_guest_additions = false
      # v.memory = 1024
      # v.cpus = 2
    end
    config.vm.communicator = "winrm"
    config.vm.hostname = "windows-2019.local"
    config.vm.network "public_network", ip: "192.168.0.1", hostname: true
    config.vm.network "forwarded_port", guest: 22, host: 3200, id: "ssh" # Set specific SSH port to avoid port collision
    config.vm.synced_folder ".", "/vagrant", disabled: true # Disble the default /vagrant share
    config.vm.synced_folder "src/", "/synced-src", automount: true # The synced source code folder
    # config.vm.provision "shell", path: "windows.ps1", privileged: true
    # if ARGV.include? '--provision-with'
    #   config.vm.provision "build-app-dist", type: "shell", inline: "cd \\\\boxsrv && npm install && npm run make", privileged: true
    # end
  end

  config.vm.define "debian-11" do |config|
    config.vm.box = "jackvanzyl/debian-11"
    config.vm.box_version = "0.1.0"
    config.vm.provider "virtualbox" do |v|
      v.gui = true
      v.name = "Debian Linux"
      v.check_guest_additions = false
      # v.memory = 1024
      # v.cpus = 2
    end
    config.vm.communicator = "ssh"
    config.vm.hostname = "debian-11.local"
    config.vm.network "public_network", ip: "192.168.0.2", hostname: true
    config.vm.network "forwarded_port", guest: 22, host: 3201, id: "ssh" # Set specific SSH port to avoid port collision
    config.vm.synced_folder ".", "/vagrant", disabled: true # Disble the default /vagrant share
    config.vm.synced_folder "src/", "/synced-src", automount: true # The synced source code folder
    # config.vm.provision "shell", path: "debian-linux.sh", privileged: true
    # if ARGV.include? '--provision-with'
    #   config.vm.provision "build-app-dist", type: "shell", inline: "cd /synced-src && npm install && npm run make", privileged: true
    # end
  end

  config.vm.define "fedora-33" do |config|
    config.vm.box = "jackvanzyl/fedora-33"
    config.vm.box_version = "0.1.0"
    config.vm.provider "virtualbox" do |v|
      v.gui = true
      v.name = "Fedora Linux"
      v.check_guest_additions = false
      # v.memory = 1024
      # v.cpus = 2
    end
    config.vm.communicator = "ssh"
    config.vm.hostname = "fedora-33.local"
    config.vm.network "public_network", ip: "192.168.0.3", hostname: true
    config.vm.network "forwarded_port", guest: 22, host: 3203, id: "ssh" # Set specific SSH port to avoid port collision
    config.vm.synced_folder ".", "/vagrant", disabled: true # Disble the default /vagrant share
    config.vm.synced_folder "src/", "/synced-src", automount: true # The synced source code folder
    # config.vm.provision "shell", path: "fedora-linux.sh", privileged: true
    # if ARGV.include? '--provision-with'
    #   config.vm.provision "build-app-dist", type: "shell", inline: "cd /synced-src && npm install && npm run make", privileged: true
    # end
  end

  config.vm.define "freebsd-13" do |config|
    config.vm.box = "jackvanzyl/freebsd-13"
    config.vm.box_version = "0.1.0"
    config.vm.provider "virtualbox" do |v|
      v.gui = true
      v.name = "FreeBSD"
      v.check_guest_additions = false
      # v.memory = 1024
      # v.cpus = 2
    end
    config.vm.communicator = "ssh"
    config.vm.hostname = "freebsd-13.local"
    config.vm.network "public_network", ip: "192.168.0.4", hostname: true
    config.vm.network "forwarded_port", guest: 22, host: 3203, id: "ssh" # Set specific SSH port to avoid port collision
    config.vm.synced_folder ".", "/vagrant", disabled: false # Disble the default /vagrant share
    config.vm.synced_folder "src/", "/synced-src", automount: true # The synced source code folder
    # config.vm.provision "shell", path: "freebsd.sh", privileged: true
    # if ARGV.include? '--provision-with'
    #   config.vm.provision "build-app-dist", type: "shell", inline: "cd /synced-src && npm install && npm run make", privileged: true
    # end
  end

  config.vm.define "freebsd-cross-build" do |config|
    config.vm.box = "jackvanzyl/freebsd-cross-build"
    config.vm.box_version = "0.1.0"
    config.vm.provider "virtualbox" do |v|
      v.gui = true
      v.name = "FreeBSD Cross Build"
      v.check_guest_additions = false
      # v.memory = 1024
      # v.cpus = 2
    end
    config.vm.guest = "freebsd-cross-build"
    config.vm.communicator = "ssh"
    config.vm.hostname = "freebsd-cross-build.local"
    config.vm.network "public_network", ip: "192.168.0.5", hostname: true
    config.vm.network "forwarded_port", guest: 22, host: 3204, id: "ssh" # Set specific SSH port to avoid port collision
    config.vm.synced_folder ".", "/vagrant", disabled: true # Disble the default /vagrant share
    config.vm.synced_folder "src/", "/synced-src", automount: true # The synced source code folder
  end
end
