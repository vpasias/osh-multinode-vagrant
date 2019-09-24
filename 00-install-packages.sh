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
        libvirt-bin \
        libvirt-dev \
        libxml2-dev \
        libxslt-dev \
        qemu \
        ruby-dev \
        unzip \
        virtualbox \
        zlib1g-dev

# NOTE(drewwalters96): Install latest vagrant version for compatibility with
# vagrant-disksize plugin.
INSTALL_LOCATION="$(mktemp -d)"
INSTALL_FILE="${INSTALL_LOCATION}/vagrant.deb"

curl -L -o "$INSTALL_FILE" \
  https://releases.hashicorp.com/vagrant/2.2.5/vagrant_2.2.5_x86_64.deb

sudo dpkg -i "$INSTALL_FILE"
rm -rf "$INSTALL_LOCATION"
