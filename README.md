# Installation of a VM on a Proxmox  

To use the script, you have to install it (of course !)  
git clone https://github.com/ZrH-Source/install-vm  

After installing the script, just run these fews commands :  
sudo chmod +x install-vm.sh  
./install-vm.sh

And follow what the script is going to ask you.  
(You can change the default value in the code as you want of course, they are my default value for my own proxmox server.)  

# WARNING
MAKE SURE THE VM IS ONLINE AND WELL STARTED WHEN THE SCRIPT IS BEING PAUSED.  
To be sure, just connect to your proxmox using the web gui, go on the vm you just created using the script (yay) and look if the vm is started correctly, you have around 1.4minutes until the next command is being started.  

Enjoy ;)
