# Installation of a VM on a Proxmox.

To use the script, you have to install it (of course !)  
git clone https://github.com/ZrH-Source/install-vm  

# Command for the usage.

To use the script, you have to make sure you have docker installed. ( docker -v )

Make sure the script (install-vm.sh) is an executable ( chmod +x install-vm.sh )
After that, use the script as normal ( ./install-vm.sh ) and follow the instruction.

# WARNING
You have to be sure the VM is well started, if not, it will not grab the ip in ips.txt. I've put a 1min delay to check if the vm is well started.
To do so, connect to your proxmox server using the web interface, and check if your vm is well started.

By the way, all the defaults values are for my own proxmox, you can change those values in the install-vm.sh and core.sh

If you need any help, contact me on discord : Zarioch la Brioche#7028 or open an issue on github.

Enjoy :)
