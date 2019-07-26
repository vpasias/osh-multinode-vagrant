if [[ $1 == "n1" ]]; then
  ssh ubuntu@172.21.1.10 -i etc/.vagrant/machines/n1/virtualbox/private_key
fi

if [[ $1 == "n2" ]]; then
  ssh ubuntu@172.21.1.11 -i etc/.vagrant/machines/n2/virtualbox/private_key
fi

if [[ $1 == "n3" ]]; then
  ssh ubuntu@172.21.1.12 -i etc/.vagrant/machines/n3/virtualbox/private_key
fi
