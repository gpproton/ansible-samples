#!/bin/bash

if ! [ -x "$(command -v sshpass)" ]; then
    echo 'Error: sshpass is not installed.' >&2
    exit 1
fi

echo 'Validate vagrant setup..'

# echo 'Starting virtual machines...'
# vagrant up

# echo 'Generating ssh key...'
# ssh-keygen -t ed25519 -C "ansible" -N '' -f ~/.ssh/ansible_dev <<<n

# Initialization playbook
ansible-playbook --become --ask-become-pass \
    playbooks/initialize.yaml

temp_user="vagrant"
temp_password=$(cat ./password/default)
ansible-playbook --become \
    --extra-vars "ansible_ssh_user=$temp_user ansible_ssh_password=$temp_password" \
    playbooks/initialize_users.yaml
