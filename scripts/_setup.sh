function st_install_debian() {
    echo 'setup debain packages..'
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y curl \
        wget python3 openssl
}

function st_install_redhat() {
    echo 'setup redhat packages..'
    sudo dnf upgrade -y
    sudo dnf install -y curl \
        wget python3 openssl
}

function st_install_opensuse() {
    echo 'setup opensuse packages..'
    sudo zypper dup -y
    sudo zypper install -y curl \
        wget python3 openssl
}

function st_install_darwin() {
    echo 'setup mac-os packages..'
    sudo brew update -y
    sudo brew install -y curl \
        wget python3 openssl
}

function st_install_packages() {
    echo "installing $os_variant requirements..."
    if [[ $os_variant =~ "Debian" ]] | [[ $os_variant =~ "Ubuntu" ]]; then
        st_install_debian
    elif [[ $os_variant =~ "Fedora" ]] | [[ $os_variant =~ "RedHat" ]]; then
        st_install_redhat
    elif [[ $os_variant =~ "openSUSE" ]]; then
        st_install_opensuse
    elif [[ $os_variant =~ "Darwin" ]]; then
        st_install_darwin
    else
        echo 'un-identified os distribution..'
    fi
}

function st_start_setup() {
    st_install_packages
    echo 'installing ansible...'
    python3 -m pip install --user ansible
}
