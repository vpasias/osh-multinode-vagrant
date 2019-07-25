echo "=== Setup auth ==="

cp /home/vagrant/.ssh/authorized_keys /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu: /home/ubuntu/.ssh

echo "=== Configuring DNS ==="

echo "=== Cloning OpenStack-Helm ==="
git clone https://opendev.org/openstack/openstack-helm-infra.git /opt/openstack-helm-infra
git clone https://opendev.org/openstack/openstack-helm.git /opt/openstack-helm

sudo chown -R ubuntu: /opt
