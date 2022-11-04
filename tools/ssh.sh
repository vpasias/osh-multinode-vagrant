#!/bin/bash

set -e

declare -A \
  NODES=( ["n1"]="172.24.1.10" ["n2"]="172.24.1.11" ["n3"]="172.24.1.12" ["n4"]="172.24.1.13" ["n5"]="172.24.1.14" ["n6"]="172.24.1.15" )

if [[ "$1" != "n1" && "$1" != "n2" && "$1" != "n3" && "$1" != "n4" && "$1" != "n5" && "$1" != "n6" ]]; then
  echo "Error: invalid node. Valid nodes include n1, n2, n3, n4, n5, n6"
  echo "Example usage:"
  echo "  ./tools/ssh.sh n1"
  exit 1
fi

ssh -o "LogLevel=FATAL" \
    -o "Compression=yes" \
    -o "DSAAuthentication=yes" \
    -o "IdentitiesOnly=yes" \
    -o "StrictHostKeyChecking=no" \
    -o "UserKnownHostsFile=/dev/null" \
    -i "etc/.vagrant/machines/$1/virtualbox/private_key" ubuntu@"${NODES[$1]}"
