#!/bin/bash
read -p " Enter your host (default : 192.168.122.53 ) : " host
host=${host:-'192.168.122.53'}
echo 'Enter your username (default : root)'
read user
user=${user:-'root'}
echo 'Enter your password '
read password
echo 'Connecting to your host on ssh and creating the virtual machine'

id=${1:-'100'}
name=${2:-'debian'}
memory=${3:-'2048'}
socket=${4:-'2'}
iso=${5:-'debian-11.3.0-amd64-netinst.iso'}

sshpass -p ${password} ssh ${user}@${host} 'qm create '${id}' --name '${name}' --cdrom local:iso/'${iso}' --memory '${memory}' --socket '${socket}