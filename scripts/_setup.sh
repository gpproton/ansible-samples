function st_install_debian() {
    echo 'setup debain packages..'
    sudo apt update
    sudo apt install -y curl \
        wget python3 openssl
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install -y vagrant
}

function st_install_fedora() {
    echo 'setup redhat packages..'
    sudo dnf update
    sudo dnf install -y curl \
        wget python3 openssl \
        dnf-plugins-core
    sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
    sudo dnf -y install vagrant
}

function st_install_redhat() {
    echo 'setup redhat packages..'
    sudo yum install -y yum-utils curl \
        wget python3 openssl
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    sudo yum -y install vagrant
}

function st_install_opensuse() {
    echo 'setup opensuse packages..'
    sudo zypper ref
    sudo zypper install -y curl \
        wget python3 openssl vagrant
}

function st_install_darwin() {
    echo 'setup mac-os packages..'
    sudo brew update -y
    sudo brew install -y curl \
        wget python3 openssl
    brew tap hashicorp/tap
    brew install hashicorp/tap/vagrant
}

function st_install_packages() {
    echo "installing $os_variant requirements..."
    if [[ $os_variant =~ "Debian" ]] | [[ $os_variant =~ "Ubuntu" ]]; then
        st_install_debian
    elif [[ $os_variant =~ "Fedora" ]]; then
        st_install_fedora
    elif [[ $os_variant =~ "CentOS" ]] | [[ $os_variant =~ "RedHat" ]]; then
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
