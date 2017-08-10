# Provision-VMs-Ansible-Playbook-Bash
Automated provisioning of Virtual Machines (VMs) on Remote Bare-Metal machines using a Bash Script and Ansible Playbook

# About
This repository consists of the following:
1. __ansible_virt.sh:__ This is bash script which needs to be run for automation
2. __main.yml:__ Ansible playbook for spawing VMs on a remote bare-metal machine

# Getting Started
1. Clone the repository
2. Give special permission to ansible_virt.sh script by executing the command: <code>$ chmod +x ansible_virt.sh</code>
3. Execute the script: <code>$ ./ansible_virt.sh</code>

# Description
Once the script is executed, it will perform the following operations:
1. Ask for the number of bare-metal machines on which the VMs have to be provisioned, along with their IP address
2. For each machine, it will ask for the number of VMs to be spawned 
3. It will then ask for the specifications of the VM to be spawned, e.g. Ram, Storage, OS, etc.
4. The script will then call Ansible Playbook <code>main.yml</code> to spawn and start the VM
