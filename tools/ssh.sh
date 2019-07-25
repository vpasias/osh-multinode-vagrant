if [[ $1 == "n1" ]]; then
  ssh ubuntu@192.168.50.4 -i etc/.vagrant/machines/n1/virtualbox/private_key
fi

if [[ $1 == "n2" ]]; then
  ssh ubuntu@192.168.50.5 -i etc/.vagrant/machines/n2/virtualbox/private_key
fi

if [[ $1 == "n3" ]]; then
  ssh ubuntu@192.168.50.6 -i etc/.vagrant/machines/n3/virtualbox/private_key
fi
