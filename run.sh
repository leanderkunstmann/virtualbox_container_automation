#!/bin/sh
vboxmanage import machines/"$vmname.ova"
vboxmanage setproperty vrdeextpack "$remote"
if [ "$remote" = "Oracle VM VirtualBox Extension Pack" ]
then
   vboxmanage modifyvm "$vmname" --vrde on
   vboxmanage storageattach "$vmname" --storagectl "Floppy" --device 0 --type fdd --medium machines"/$vmname.img"
   vboxheadless --startvm "$vmname"
else
   vboxmanage modifyvm "$vmname" --vrde on
   vboxmanage modifyvm "$vmname" --vrdeproperty VNCPassword=secret
   # vboxmanage storageattach "$vmname" --storagectl "Floppy" --device 0 --type fdd --medium machines"/$vmname.img"
   vboxheadless --startvm "$vmname"
fi
