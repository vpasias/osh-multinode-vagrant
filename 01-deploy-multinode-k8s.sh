#!/bin/bash

set -xe

declare -A \
  NODES=( ["n1"]="172.24.1.10" ["n2"]="172.24.1.11" ["n3"]="172.24.1.12" ["n4"]="172.24.1.13" ["n5"]="172.24.1.14" ["n6"]="172.24.1.15" )

function copy_keys_to_node {
  id_key="etc/.vagrant/machines/$1/virtualbox/private_key"

  for node in "${!NODES[@]}"; do
    key="etc/.vagrant/machines/$node/virtualbox/private_key"

    scp -o "LogLevel=FATAL" \
        -o "Compression=yes" \
        -o "DSAAuthentication=yes" \
        -o "IdentitiesOnly=yes" \
        -o "StrictHostKeyChecking=no" \
        -o "UserKnownHostsFile=/dev/null" \
        -i "$id_key" "$key" ubuntu@"${NODES[$1]}":/home/ubuntu/.ssh/"$node"
  done
}

function execute_master_cmd {
    ssh -o "LogLevel=FATAL" \
        -o "Compression=yes" \
        -o "DSAAuthentication=yes" \
        -o "IdentitiesOnly=yes" \
        -o "StrictHostKeyChecking=no" \
        -o "UserKnownHostsFile=/dev/null" \
        -i "etc/.vagrant/machines/n1/virtualbox/private_key" \
        ubuntu@172.24.1.10 "cd /opt/openstack-helm-infra && $*"
}

# Start/provision Vagrant VMs
pushd "$(pwd)"
cd etc

vagrant up --provider=virtualbox
popd

# Copy Vagrant SSH keys to all nodes
for node in "${!NODES[@]}"; do
  copy_keys_to_node "$node"
done

# Install GNU Make on n1
execute_master_cmd "sudo apt-get update"
execute_master_cmd "sudo apt-get install make"

# Deploy K8s
execute_master_cmd "make dev-deploy setup-host multinode"
execute_master_cmd "make dev-deploy k8s multinode"
