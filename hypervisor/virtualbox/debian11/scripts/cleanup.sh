#!/bin/bash -eux

# Uninstall Ansible and dependencies.
pip3 uninstall ansible
#apt-get remove python3-pip python3-dev -y

# Apt cleanup.
apt autoremove -y
apt update

#  Blank netplan machine-id (DUID) so machines get unique ID generated on boot.
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync