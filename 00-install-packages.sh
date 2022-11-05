#!/bin/bash

# Copyright 2017 The Openstack-Helm Authors.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.

set -xe

sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y vagrant
sudo DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        ca-certificates \
        git \
        make \
        nmap \
        curl \
        dnsmasq-base \
        ebtables \
        qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils \
        libvirt-dev \
        libxml2-dev \
        libxslt-dev \
        qemu \
        ruby-dev \
        unzip \
        zlib1g-dev

# Install VirtualBox
curl https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor > oracle_vbox_2016.gpg
curl https://www.virtualbox.org/download/oracle_vbox.asc | gpg --dearmor > oracle_vbox.gpg

sudo install -o root -g root -m 644 oracle_vbox_2016.gpg /etc/apt/trusted.gpg.d/
sudo install -o root -g root -m 644 oracle_vbox.gpg /etc/apt/trusted.gpg.d/

echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

sudo apt-get update
sudo apt-get install linux-headers-$(uname -r) dkms -y
sudo apt-get install virtualbox-6.1 -y    

sudo vboxmanage setproperty machinefolder /mnt/extra/libvirt/
vboxmanage list systemproperties | grep folder
vboxmanage list hostonlyifs
sudo adduser iason vboxusers

# NOTE: Install latest vagrant version for compatibility with vagrant-disksize plugin.
INSTALL_LOCATION="$(mktemp -d)"
INSTALL_FILE="${INSTALL_LOCATION}/vagrant.deb"

curl -L -o "$INSTALL_FILE" \
  https://releases.hashicorp.com/vagrant/2.2.18/vagrant_2.2.18_x86_64.deb

sudo dpkg -i "$INSTALL_FILE"
rm -rf "$INSTALL_LOCATION"

vagrant plugin install vagrant-disksize
