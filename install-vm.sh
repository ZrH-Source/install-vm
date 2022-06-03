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

sh core.sh -n $name -m $memory -s $socket -i $iso -h $host -u user -p $passwd $id