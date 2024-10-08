#!/bin/bash -eux

# Add vagrant user to sudoers.
echo "jenkins        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Disable daily apt unattended updates. Is this needed for Debian?
# echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
