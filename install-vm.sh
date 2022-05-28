#!/bin/bash

if [ $(which ansible &>/dev/null) ]; then
echo 'Installing ansible.'
sudo add-apt-repository -y --update ppa:ansible/ansible
sudo apt install software-properties-common ansible -y
fi

read -p "Enter the id of the vm (100) : " id
read -p "Enter the name of the vm (debian) : " name
read -p "Enter the memory of the vm (2048) : " memory
read -p "Enter the socket of the vm (2) : " socket
read -p "Enter the iso of the vm (debian-11.3.0-amd64-netinst.iso) : " iso

id=${id:-'100'}
name=${name:-'debian'}
memory=${memory:-'2048'}
socket=${socket:-'2'}
iso=${iso:-'debian-11.3.0-amd64-netinst.iso'}
current_extra_vars_file=“extra_vars.$(date "+%Y.%m.%d-%H.%M").yml“

tee $current_extra_vars_file <<EOF
id: $id
name: $name
memory: $memory
socket: $socket
iso: $iso
EOF

echo 'Running Ansible playbook.'
sudo ansible-playbook -i hosts.ini install-vm.yml -e @current_extra_vars_file.yml