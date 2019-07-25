echo "=== Setup auth ==="

cp /home/vagrant/.ssh/authorized_keys /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu: /home/ubuntu/.ssh

echo "=== Configuring Inventory ==="

cat > /opt/openstack-helm-infra/tools/gate/devel/multinode-inventory.yaml <<EOF
all:
  children:
    primary:
      hosts:
        node_one:
          ansible_port: 22
          ansible_host: 192.168.50.4
          ansible_user: ubuntu
          ansible_ssh_private_key_file: /home/ubuntu/.ssh/n1
          ansible_ssh_extra_args: -o "LogLevel=FATAL" -o "Compression=yes" -o "DSAAuthentication=yes" -o "IdentitiesOnly=yes" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"
    nodes:
      hosts:
        node_two:
          ansible_port: 22
          ansible_host: 192.168.50.5
          ansible_user: ubuntu
          ansible_ssh_private_key_file: /home/ubuntu/.ssh/n2
          ansible_ssh_extra_args: -o "LogLevel=FATAL" -o "Compression=yes" -o "DSAAuthentication=yes" -o "IdentitiesOnly=yes" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"
        node_three:
          ansible_port: 22
          ansible_host: 192.168.50.6
          ansible_user: ubuntu
          ansible_ssh_private_key_file: /home/ubuntu/.ssh/n3
          ansible_ssh_extra_args: -o "LogLevel=FATAL" -o "Compression=yes" -o "DSAAuthentication=yes" -o "IdentitiesOnly=yes" -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"
EOF

echo "=== Configuring Default Interface ==="

cat /opt/openstack-helm-infra/tools/gate/devel/multinode-vars.yaml << EOF
kubernetes_network_default_device: enp0s8
EOF

echo "=== Cloning OpenStack-Helm ==="
git clone https://opendev.org/openstack/openstack-helm-infra.git /opt/openstack-helm-infra
git clone https://opendev.org/openstack/openstack-helm.git /opt/openstack-helm

sudo chown -R ubuntu: /opt
