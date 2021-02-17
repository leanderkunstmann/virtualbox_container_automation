#!/bin/sh
vboxmanage import machines/"$vmname.ova"
vboxmanage setproperty vrdeextpack "$remote"
vboxmanage modifyvm "$vmname" --vrde on
if [ "$remote" != "Oracle VM VirtualBox Extension Pack" ]
then
   vboxmanage modifyvm "$vmname" --vrdeproperty VNCPassword=secret
fi
vboxmanage storageattach "$vmname" --storagectl "Floppy" --device 0 --type fdd --medium machines"/$vmname.img"
vboxheadless --startvm "$vmname"
