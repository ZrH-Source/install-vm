#!/bin/bash
read -p " Enter your host (default : 192.168.122.53 ) : " host
host=${host:-'192.168.122.53'}
read -p "Enter your username (default : root) :" user
user=${user:-'root'}
read -s -p "Enter your password : " password

echo "Downloading the latest version of sshpass"
sudo apt install sshpass
sudo apt update
echo 'Connecting to your host on ssh and creating the virtual machine'

id=${1:-'100'}
name=${2:-'debian'}
memory=${3:-'2048'}
socket=${4:-'2'}
iso=${5:-'debian-11.3.0-amd64-netinst.iso'}

sshpass -p ${password} ssh ${user}@${host} 'qm create '${id}' --name '${name}' --cdrom local:iso/'${iso}' --memory '${memory}' --socket '${socket}