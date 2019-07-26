# OSH Multinode Vagrant Project

[![Build Status](https://travis-ci.org/drewwalters96/osh-multinode-vagrant.svg?branch=master)](https://travis-ci.org/drewwalters96/osh-multinode-vagrant)

Scripts to deploy a multinode Kubernetes cluster using the OpenStack-Helm
project and kubeadm.

## Getting Started

Setup an Ubuntu 16.04 (Xenial) or Ubuntu 18.04 (Bionic) machine that supports
nested virtualization. Clone this repository and follow the directions below.

**Run all scripts from the root directory of this repository.**

### Install dependencies

```bash
./00-install-packages.sh
```

### Install dependencies

```bash
./01-deploy-multinode-k8s.sh
```

## Use Kubernetes

Access each node using the SSH script provided. Kubectl and Helm are available
on node one (n1).

```bash
./tools/ssh.sh n1
```
