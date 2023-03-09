#!/bin/bash

if [ -x "$(command -v lsb_release)" ]; then
    os_variant=$(lsb_release -is)
else
    os_variant=$(uname -s)
fi

function load_env() {
    echo 'loading enviroment varibles from file...'

    env_file='.env'
    if [ -f $PWD/$env_file ]; then
        env_file='.env.sample'
    fi

    set -a
    source <(cat $env_file | sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
    set +a

    unset $env_file
}
