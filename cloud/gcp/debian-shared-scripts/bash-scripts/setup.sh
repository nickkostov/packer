#!/bin/bash -eux

echo "User Configuration"
echo "jenkins        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
