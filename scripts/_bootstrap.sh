#!/bin/bash

if ! [ -x "$(command -v sshpass)" ]; then
    echo 'Error: sshpass is not installed.' >&2
    exit 1
fi

function ax_start_machine() {
    echo 'Starting virtual machines...'
    vagrant up
}

function ax_generate_ssh_key() {
    echo 'Generating ssh key...'
    ssh-keygen -t ed25519 -C "ansible" -N '' -f ~/.ssh/ansible_dev <<<n
}

function ax_setup_ssh_init() {
    ansible-playbook --become --ask-become-pass \
        $PWD/playbooks/initialize.yaml
}

function ax_setup_ssh_users() {
    temp_user="$SETUP_USER"
    temp_password=$(cat .secret/password.txt)
    ansible-playbook --become \
        --extra-vars "ansible_ssh_user=$temp_user ansible_ssh_password=$temp_password" \
        $PWD/playbooks/initialize_users.yaml
}

function ax_run_all() {
    echo "starting stack bootstrap.."

    ax_setup_ssh_init
    ax_setup_ssh_users
}
