#!/bin/bash

function vg_init() {
    fi_username=vagrant
    fi_password=$(cat /tmp/password.txt)

    echo 'initializing...'
    sleep 5
}

function vg_set_password() {
    echo 'Setting default password...'
    usermod --password $(echo $fi_password | openssl passwd -1 -stdin) $fi_username
}

function vg_enable_password() {
    echo 'enabling password auth ...'
    sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
}

function vg_restart_ssh() {
    echo "Restarting ssh service.."
    systemctl restart sshd
}

function vg_run_all() {
    vg_init
    vg_set_password
    vg_enable_password
    vg_restart_ssh
    rm -rf /tmp/*
}
