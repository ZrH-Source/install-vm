#!/bin/bash

if [ $(which ansible &>/dev/null) ]; then
echo 'Installing ansible.'
sudo add-apt-repository -y --update ppa:ansible/ansible
sudo apt install software-properties-common ansible -y
fi

if [ $(which sshpass &>/dev/null) ]; then
echo 'Installing ansible.'
sudo apt install sshpass -y
fi

read -p "Enter the ip of the proxmox (192.168.122.217) : " host
read -p "Enter the username of the proxmox (root) : " user
read -s -p "Enter the password of the proxmox : " passwd
echo ''
read -p "Enter the id of the vm (100) : " id
read -p "Enter the name of the vm (debian) : " name
read -p "Enter the memory of the vm (2048) : " memory
read -p "Enter the socket of the vm (2) : " socket
read -p "Enter the iso of the vm (debian-live-11.3.0-amd64-gnome.iso) : " iso

id=${id:-'100'}
name=${name:-'debian'}
memory=${memory:-'2048'}
socket=${socket:-'2'}
iso=${iso:-'debian-live-11.3.0-amd64-gnome.iso'}
host=${host:-"192.168.122.217"}
user=${user:-"root"}
current_extra_vars_file="extra_vars.$(date "+%Y.%m.%d-%H.%M").yml"

echo "Creating hosts.ini"
tee "hosts.ini" <<EOF
[proxmox]
proxmox ansible_host=$host ansible_ssh_user=$user ansible_ssh_pass=$passwd
EOF
echo ''

echo "Creating $current_extra_vars_file"
tee "$current_extra_vars_file" <<EOF
id: $id
name: $name
memory: $memory
socket: $socket
iso: $iso
EOF

tee "env.env" <<EOF
APP_ID=$id
APP_NAME=$name
APP_MEMORY=$memory
APP_SOCKET=$socket
APP_ISO=$iso
EXTRA_VARS=$current_extra_vars_file
EOF

docker-compose build install-vm
docker-compose --env-file env.env up install-vm

rm -f $current_extra_vars_file hosts.ini env.env