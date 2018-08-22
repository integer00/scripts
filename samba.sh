#!/bin/bash
ATTACHABLE_DRIVE=$(diskutil list|grep "2.0 TB"|awk -F 'TB' '{print $2}'|head -1|awk -F ' ' '{print $1}')
echo " Found ${ATTACHABLE_DRIVE} "
echo " Fixing permissions... " 
sudo chmod 666 /dev/${ATTACHABLE_DRIVE}
if [ $? -eq 0 ]; then
	echo " OK "
else
	echo "permission error"
fi

echo -n " Mounting drive to virtualbox: "

VBoxManage storageattach arch-samba --storagectl SATA --port 1 --device 0 --type hdd --medium /garbage/VMmachines/${ATTACHABLE_DRIVE}.vmdk

if [ $? -eq 0 ]; then
	echo " OK "
else
	echo "Not attached."
fi

echo " Starting VirtualMachine..." 

VBoxManage startvm arch-samba --type headless
