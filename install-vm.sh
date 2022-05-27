#!/bin/bash
echo 'Installing ansible.'
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible 

echo 'Running Ansible playbook.'
sudo ansible-playbook -i hosts.ini install-vm.yml -e @extra-var.yml