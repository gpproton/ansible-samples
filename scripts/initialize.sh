#!/bin/bash

echo 'loading project enviroment variables...'
fi_username=vagrant
fi_password=$(cat /tmp/default_password)

echo 'initializing...'
sleep 5

echo 'Setting default password...'
usermod --password $(echo $fi_password | openssl passwd -1 -stdin) $fi_username

echo 'enabling password auth ...'
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

echo "Restarting ssh service.."
systemctl restart sshd
