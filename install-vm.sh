#!/bin/bash
echo 'Installing ansible.'
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible 

read -p "Enter the id of the vm (100) : " id
read -p "Enter the name of the vm (debian) : " name
read -p "Enter the memory of the vm (2048) : " memory
read -p "Enter the socket of the vm (2) : " socket
read -p "Enter the iso of the vm : (debian-11.3.0-amd64-netinst.iso) " iso

id=${id:-'100'}
name=${name:-'debian'}
memory=${memory:-'2048'}
socket=${socket:-'2'}
iso=${iso:-'debian-11.3.0-amd64-netinst.iso'}
current_time=$(date "+%Y.%m.%d-%H.%M")

( echo "id: $id";
  echo "name: $name";
  echo "memory: $memory";
  echo "socket: $socket";
  echo "iso: $iso";
) >extra-var.$current_time.yml

echo 'Running Ansible playbook.'
sudo ansible-playbook -i hosts.ini install-vm.yml -e @extra-var.$current_time.yml