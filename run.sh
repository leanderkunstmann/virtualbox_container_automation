#!/bin/sh
vboxmanage import machines/"$vmname.ova"
vboxmanage setproperty vrdeextpack "$remote"
vboxmanage modifyvm "$vmname" --vrde on
vboxmanage modifyvm "$vmname" --vrdeproperty VNCPassword=secret
#vboxmanage storageattach "$vmname" --storagectl "Floppy" --device 0 --type fdd --medium "$vmname.img"
vboxheadless --startvm "$vmname"