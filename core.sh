#!/bin/bash

while getopts n:m:s:i: opt
do
    case "${opt}" in
        n) name=${OPTARG} ;;
        m) memory=${OPTARG} ;;
        s) socket=${OPTARG} ;;
        i) iso=${OPTARG} ;;
    esac
done

id=${id:-'100'}
name=${name:-'debian'}
memory=${memory:-'2048'}
socket=${socket:-'2'}
iso=${iso:-'debian-live-11.3.0-amd64-gnome.iso'}

for id in $@; do :; done # Last args

echo 'Running Ansible playbook.'
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini install-vm.yml -e @extra_vars.yml # Create and start the virtual machine with the options in extra_vars.yml

echo 'Waiting for the vm to start.'
echo ''
chown root:root /tmp/ips.txt
sleep 60
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini retrieve_ip.yml -e @extra_vars.yml # Grab the Ip with an arp -a in docker
echo 'Stopping the vm.'
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini stopping-vm.yml -e @extra_vars.yml # Stop the vm 