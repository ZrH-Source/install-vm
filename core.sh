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
current_extra_vars_file="extra_vars.$(date "+%Y.%m.%d-%H.%M").yml"

for id in $@; do :; done # Last args

echo 'Running Ansible playbook.'
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini install-vm.yml -e @extra_vars.yml

echo 'Waiting for the vm to start.'
echo ''
sleep 60
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini retrieve_ip.yml -e @extra_vars.yml
echo 'Stopping the vm.'
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini stopping-vm.yml -e @extra_vars.yml
