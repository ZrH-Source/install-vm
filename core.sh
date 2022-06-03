#!/bin/bash

while getopts n:m:s:i:h:u:p: opt
do
    case "${opt}" in
        n) name=${OPTARG} ;;
        m) memory=${OPTARG} ;;
        s) socket=${OPTARG} ;;
        i) iso=${OPTARG} ;;
        h) host=${OPTARG} ;;
        u) user=${OPTARG} ;;
        p) passwd=${OPTARG} ;;
    esac
done

id=${i:-'100'}
name=${name:-'debian'}
memory=${memory:-'2048'}
socket=${socket:-'2'}
iso=${iso:-'debian-live-11.3.0-amd64-gnome.iso'}
host=${host:-"192.168.122.217"}
user=${user:-"root"}
current_extra_vars_file="extra_vars.$(date "+%Y.%m.%d-%H.%M").yml"

for i in $@; do :; done # Last args

tee "hosts.ini" <<EOF
[proxmox]
proxmox ansible_host=$host ansible_ssh_user=$user ansible_ssh_pass=$passwd
EOF

tee $current_extra_vars_file <<EOF
id: $i
name: $name
memory: $memory
socket: $socket
iso: $iso
EOF

echo 'Running Ansible playbook.'
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini install-vm.yml -e @$current_extra_vars_file

echo 'Waiting for the vm to start.'
sleep 100
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini retrieve_ip.yml -e @$current_extra_vars_file
rm -f $current_extra_vars_file hosts.ini