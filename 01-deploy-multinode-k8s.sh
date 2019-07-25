#!/bin/bash

set -xe

START_DIR=$(pwd)

sudo chown -R ubuntu: /opt
rm -rf /opt/openstack-helm*
git clone https://git.openstack.org/openstack/openstack-helm-infra.git /opt/openstack-helm-infra
git clone https://git.openstack.org/openstack/openstack-helm.git /opt/openstack-helm

cat > /opt/openstack-helm-infra/tools/gate/devel/multinode-inventory.yaml <<EOF
all:
  children:
    primary:
      hosts:
        node_one:
          ansible_port: 22
          ansible_host: 192.168.50.4
          ansible_user: ubuntu
          ansible_ssh_private_key_file: /home/ubuntu/etc/.vagrant/machines/n1/virtualbox/private_key
          ansible_ssh_extra_args: -o "LogLevel=FATAL" -o "Compression=yes" -o "DSAAuthentication=yes" -o "IdentitiesOnly=yes" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"
    nodes:
      hosts:
        node_two:
          ansible_port: 22
          ansible_host: 192.168.50.5
          ansible_user: ubuntu
          ansible_ssh_private_key_file: /home/ubuntu/etc/.vagrant/machines/n2/virtualbox/private_key
          ansible_ssh_extra_args: -o "LogLevel=FATAL" -o "Compression=yes" -o "DSAAuthentication=yes" -o "IdentitiesOnly=yes" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"
        node_three:
          ansible_port: 22
          ansible_host: 192.168.50.6
          ansible_user: ubuntu
          ansible_ssh_private_key_file: /home/ubuntu/etc/.vagrant/machines/n3/virtualbox/private_key
          ansible_ssh_extra_args: -o "LogLevel=FATAL" -o "Compression=yes" -o "DSAAuthentication=yes" -o "IdentitiesOnly=yes" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"
EOF

cd etc
vagrant up

cd /opt/openstack-helm-infra
make dev-deploy setup-host multinode
make dev-deploy k8s multinode

cd "${START_DIR}"
