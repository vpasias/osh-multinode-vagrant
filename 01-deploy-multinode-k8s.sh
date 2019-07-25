#!/bin/bash

set -xe

pushd $(pwd)

cd etc

vagrant up

scp -i .vagrant/machines/n1/virtualbox/private_key .vagrant/machines/n1/virtualbox/private_key ubuntu@192.168.50.4:.ssh/n1
scp -i .vagrant/machines/n1/virtualbox/private_key .vagrant/machines/n2/virtualbox/private_key ubuntu@192.168.50.4:.ssh/n2
scp -i .vagrant/machines/n1/virtualbox/private_key .vagrant/machines/n3/virtualbox/private_key ubuntu@192.168.50.4:.ssh/n3

scp -i .vagrant/machines/n2/virtualbox/private_key .vagrant/machines/n1/virtualbox/private_key ubuntu@192.168.50.5:.ssh/n1
scp -i .vagrant/machines/n2/virtualbox/private_key .vagrant/machines/n2/virtualbox/private_key ubuntu@192.168.50.5:.ssh/n2
scp -i .vagrant/machines/n2/virtualbox/private_key .vagrant/machines/n3/virtualbox/private_key ubuntu@192.168.50.5:.ssh/n3

scp -i .vagrant/machines/n3/virtualbox/private_key .vagrant/machines/n1/virtualbox/private_key ubuntu@192.168.50.6:.ssh/n1
scp -i .vagrant/machines/n3/virtualbox/private_key .vagrant/machines/n2/virtualbox/private_key ubuntu@192.168.50.6:.ssh/n2
scp -i .vagrant/machines/n3/virtualbox/private_key .vagrant/machines/n3/virtualbox/private_key ubuntu@192.168.50.6:.ssh/n3

popd

ssh -i etc/.vagrant/machines/n1/virtualbox/private_key ubuntu@192.168.50.4 "sudo apt-get update ; sudo apt-get install make ; cd /opt/openstack-helm-infra ; make dev-deploy setup-host multinode ; make dev-deploy k8s multinode"
