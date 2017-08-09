#!/bin/bash

#Ask for number of physical machines are there
echo Enter the number Bare-metal machines where the VMs are to be installed
read mach

#Asking user to enter the IP addresses of the bare-metal machines
for ((i=1; i<=$mach; ++i))
do
	echo Enter the IP address of machine $i
        read IP
        sudo echo "$IP ansible_connection=ssh" | sudo tee --append /etc/ansible/hosts
        echo Bare-metal machine with IP address $IP added to the inventory

	#Ask for the number of VMs to provision on the machine
	echo How many VMs to provision on the machine with IP address $IP
	read vm	
	
	#Provision VMs
	for ((j=1; j<=$vm; ++j))
	do
		echo Enter the details for VM $j on machine $i with IP address $IP

		#Creating VMs
		echo 1. Name of the VM
		echo 2. RAM to be allocated to the VM '(in GB)'
		echo 3. Storage to be given to VM '(in GB)'
		echo 4. OS of VM '(centos, ubuntu16, etc)'
		echo 5. Type of OS '(linux, etc)'
		echo 6. Variant of OS '(ubuntutrusty, rhel7.0)'
		echo Enter your options:
		read vm_name
		read vm_ram
		read vm_storage
		read vm_os
		read vm_os_type
		read vm_os_variant

		if ["$vm_os" == "centos"]; then
			$vm_url = "http://mirror.teklinks.com/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-1611.iso"
		elif ["$vm_os" == "ubuntu16"]; then
			$vm_url = "http://releases.ubuntu.com/16.04.3/ubuntu-16.04.3-server-amd64.iso?_ga=2.33036158.1198871485.1502319374-48568553.1474219969"
		else
			echo VM image not supported
		fi

		ansible-playbook --ask-su-pass -s --extra-vars "vm_name=$vm_name vm_ram=$vm_ram vm_storage=$vm_storage vm_url=$vm_url vm_os_type=$vm_os_type vm_os_variant=$vm_os_variant group=$IP" main.yml
		
		echo VM $j on machine $i configured succesfully
	done

	echo All $vm VM'(s)' have been succesfully configured on machine $i
done
