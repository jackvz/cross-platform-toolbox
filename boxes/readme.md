# [Packer](https://www.packer.io/) Boxes for [Vagrant Cloud](https://app.vagrantup.com/) (and [Docker Hub](https://hub.docker.com/))

## Overview

The Windows, Linux (Ubuntu, Debian and Fedora) and FreeBSD Packer templates here are based on the [Chef Bento box templates](https://github.com/chef/bento). [License and Authors](license.md).

To set up and configure macOS box with Packer, if so inclined and running on Apple hardware, [the `mcandre` collection of Packer templates](https://github.com/mcandre/) includes a box template for macOS.

The [FreeBSD Cross Build box template](./freebsd-cross-build/freebsd-cross-build.json) is inspired by the [`snek` FreeBSD cross compiler](https://github.com/mcandre/snek) and made possible by the awesomeness of [Clang](https://clang.llvm.org/) and [LLVM](https://clang.llvm.org/).

## Requirements

Get [Packer](https://www.packer.io/), [Vagrant](https://www.vagrantup.com/downloads), and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and/or [QEMU](https://www.qemu.org/download/), depending on which virtualiser(s) you prefer (QEMU recommended). If you want to also create Docker images, [get Docker](https://docs.docker.com/get-docker/). All available for Windows, macOS, Linux and FreeBSD.

Install the Vagrant plugin(s):

```sh
vagrant plugin install virtualbox
vagrant plugin install qemu
```


### Get the Operating System Installers

To avoid downloading the installation media with every build, and so to speed up the build process, download the installers first:

```sh
curl -o sources/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso https://software-download.microsoft.com/download/pr/17763.737.190906-2324.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us_1.iso
curl -o sources/ubuntu-21.10-live-server-amd64.iso http://releases.ubuntu.com/impish/ubuntu-21.10-live-server-amd64.iso
curl -o sources/debian-11.3.0-amd64-netinst.iso http://cdimage.debian.org/cdimage/release/11.3.0/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso
curl -o sources/Fedora-Server-dvd-x86_64-33-1.2.iso http://download.fedoraproject.org/pub/fedora/linux/releases/33/Server/x86_64/iso/Fedora-Server-dvd-x86_64-33-1.2.iso
curl -o sources/FreeBSD-13.0-RELEASE-amd64-disc1.iso https://download.freebsd.org/ftp/releases/amd64/amd64/ISO-IMAGES/13.0/FreeBSD-13.0-RELEASE-amd64-disc1.iso
```

## Build and Test

Go to the box definition folder:

```sh
cd [windows|debian|fedora|freebsd]
```

Validate the box definition, build it and a Packer box template will be in `boxes\builds`:
```sh
export PACKER_LOG=1
packer validate [windows-2019|debian-11.3-amd64|fedora-33-x86_64|freebsd-13.0-amd64].json
packer build [windows-2019|debian-11.3-amd64|fedora-33-x86_64|freebsd-13.0-amd64].json
```

Register the box template as a Vagrant box on your machine:
```sh
vagrant box add --force --name [windows-2019|debian-11|fedora-33|freebsd-13] ../builds/[windows-2019|debian-11|fedora-33|freebsd-13]-virtualbox.box
```

Test the box out by starting it, and keep an eye on VirtualBox to verify that everything's running, or run a [Vagrant command](https://www.vagrantup.com/docs/cli) against the box.

```sh
vagrant init --force [windows-2019|debian-11|fedora-33|freebsd-13]
vagrant up
...
vagrant destroy default
```

And we're done. You can remove the box template from your machine and return to the boxes folder.

```sh
vagrant box remove [windows-2019|debian-11|fedora-33|freebsd-13]
cd ..
```

## Publish

### Vagrant Cloud

Log in and create or update a box entry in [Vagrant Cloud](https://app.vagrantup.com/):

```sh
vagrant auth login
```

```sh
vagrant cloud publish --release jackvanzyl/[windows-2019|debian-11|fedora-33|freebsd-13] 0.1.0 virtualbox ./builds/[windows-2019|debian-11|fedora-33|freebsd-13]-virtualbox.box --description '[description]'
```

### Docker Hub

Get the virtual hard drive from the box file, and convert it to a raw disk image:

```sh
tar -xf ./builds/[debian-11|fedora-33]-virtualbox.box
vboxmanage clonehd ./builds/[debian-11.1-amd64|fedora-33]-disk001.vmdk --format raw ./builds/disk-img.raw
``` 

Access the raw virtual drive with [Guestfish](https://libguestfs.org/guestfs-recipes.1.html), and create a compressed archive of the contents of the system disk part:

```sh
# virt-filesystems -a disk-img.raw
guestfish --ro -a disk-img.raw run : list-filesystems
guestfish --ro -a disk-img.raw run : launch
guestfish --ro -a disk-img.raw run : mount [disk-image-part] /
guestfish --ro -a disk-img.raw run : tgz-out / filesystem.tar.gz
```

Register the filesystem archive as a Docker image on your machine:

```sh
docker import ./builds/filesystem.tar.gz [debian-11|fedora-33]:0.1.0
```

Run the Docker image with a shell and with a directory mounted:

```sh
docker run -ti -v ./work:/work [debian-11|fedora-33]:0.1.0 /bin/bash
```

Log into [Docker Hub](https://hub.docker.com/) and publish the box as a Docker image:

```sh
docker login
docker tag [debian-11|fedora-33]:0.1.0 jackvanzyl1/[debian-11|fedora-33]:0.1.0
docker image push jackvanzyl1/[debian-11|fedora-33]:0.1.0
```

You can now remove the Docker containers and images:

```sh
docker container rm [debian-11|fedora-33]
docker image rm [debian-11|fedora-33]
```

## General

### Vagrant

To show all box templates registered on your machine:

```sh
vagrant box list
```

To show the status of all boxes created on your machine:

```sh
vagrant status
```

### Docker

To show all Docker images registered on your machine and in registries:

```sh
docker image ls
```

To show all containers running on your machine:

```sh
docker container ls
```

## Publish All

```sh
vagrant cloud publish --release --no-private jackvanzyl/windows-2019 0.1.0 virtualbox ./builds/windows-2019-virtualbox.box --short-description 'A Windows 2019 Server Box' --description 'A **[Microsoft Windows 2019 Server Vagrant Box](https://github.com/jackvz/cross-platform-toolbox/blob/main/boxes/windows/windows-2019.json)** with [Python 2.7](https://www.python.org/), [Node.js](https://nodejs.org/en/) and [Git](https://git-scm.com/), and [Boxstarter](https://boxstarter.org/), the [Microsoft C++ toolset](https://docs.microsoft.com/en-us/cpp/build/building-on-the-command-line?view=msvc-170) and [Consul](https://www.consul.io/).'
vagrant cloud publish --release --no-private jackvanzyl/ubuntu-21 0.1.0 virtualbox ./builds/ubuntu-21-virtualbox.box --short-description 'An Ubuntu 21 AMD64 Box' --description 'An **[Ubuntu 21 AMD64 Vagrant Box](https://github.com/jackvz/cross-platform-toolbox/blob/main/boxes/ubuntu/ubuntu-21.10-amd64.json)** with [Python 2](https://www.python.org/), [Node.js](https://nodejs.org/en/) and [Git](https://git-scm.com/), and [Consul](https://www.consul.io/).'
vagrant cloud publish --release --no-private jackvanzyl/debian-11 0.1.0 virtualbox ./builds/debian-11-virtualbox.box --short-description 'A Debian 11 AMD64 Box' --description 'A **[Debian 11 AMD64 Vagrant Box](https://github.com/jackvz/cross-platform-toolbox/blob/main/boxes/debian-11/debian-11.3-amd64.json)** with [Python 2.7](https://www.python.org/), [Node.js](https://nodejs.org/en/) and [Git](https://git-scm.com/), and [Consul](https://www.consul.io/).'
vagrant cloud publish --release --no-private jackvanzyl/fedora-33 0.1.0 virtualbox ./builds/fedora-33-virtualbox.box --short-description 'A Fedora 33 Intel64 Box' --description 'A **[Fedora 33 Intel64 Vagrant Box](https://github.com/jackvz/cross-platform-toolbox/blob/main/boxes/fedora/fedora-33-x86_64.json)** with [Python 2](https://www.python.org/), [Node.js](https://nodejs.org/en/) and [Git](https://git-scm.com/), and [Consul](https://www.consul.io/).'
vagrant cloud publish --release --no-private jackvanzyl/freebsd-13 0.1.0 virtualbox ./builds/freebsd-13-virtualbox.box --short-description 'A FreeBSD 13 AMD64 Box' --description 'A **[FreeBSD 13 AMD64 Vagrant Box](https://github.com/jackvz/cross-platform-toolbox/blob/main/boxes/freebsd-13/freebsd-13.0-amd64.json)** with [Python 2](https://www.python.org/), [Node.js](https://nodejs.org/en/) and [Git](https://git-scm.com/), and [Consul](https://www.consul.io/).'

vagrant cloud publish --release --no-private jackvanzyl/freebsd-cross-build 0.1.0 virtualbox ./builds/freebsd-cross-build-virtualbox.box --short-description 'A Cross Compiler Box for FreeBSD' --description 'A **[Debian 11 AMD64 Vagrant Box for Cross Compiling to FreeBSD 13](https://github.com/jackvz/cross-platform-toolbox/blob/main/boxes/freebsd-cross-build/freebsd-cross-build.json)** based on the [`snek` FreeBSD Cross Compiler](https://github.com/mcandre/snek).'
```
