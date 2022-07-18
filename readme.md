# Cross-Platform

## Software Engineering Environment

### Overview

Automated setup of Windows, Linux (Debian and Fedora) and FreeBSD build environments, as guest virtual machines, with synced project source code between the guest boxes and your computer.

### Installation

Get [Vagrant](https://www.vagrantup.com/downloads), and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and/or [QEMU](https://www.qemu.org/download/), depending on which virtualiser(s) you prefer, available for Windows, macOS, Linux and FreeBSD.

Install the Vagrant plugin(s):

```sh
vagrant plugin install virtualbox
vagrant plugin install qemu
```

### Build Boxes

The build boxes are set up with [Python](https://www.python.org/), [Node](https://nodejs.org/) and [Git](https://git-scm.com/), as well as [Consul](https://www.consul.io/).

The `src` folder will be synced to `/synced-src` in the Linux (Debian and Fedora) and FreeBSD boxes, and in a network drive called `synced-src (\\boxsrv)` in the Windows box.

The [box templates](./boxes/readme.md) are created with [Packer](https://www.packer.io/).

#### Building for Multiple Platforms

Start a Windows, Linux or FreeBSD box and access it, with your project's source code already on the box and ready to work on:

```sh
vagrant up [windows-2019|debian-11|fedora-33|freebsd-13]
vagrant ssh [windows-2019|debian-11|fedora-33|freebsd-13]
```

If you need to cross compile something from Linux to FreeBSD, use the [FreeBSD Cross Build box](./freebsd-cross-build/freebsd-cross-build.json) (made possible by the awesomeness of [Clang](https://clang.llvm.org/) and [LLVM](https://clang.llvm.org/)):

```sh
vagrant up freebsd-cross-build
vagrant ssh freebsd-cross-build
```
