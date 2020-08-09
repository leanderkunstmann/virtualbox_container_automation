#!/bin/sh
vboxmanage import machines/"$vmname.ova"
vboxmanage setproperty vrdeextpack "$remote"
vboxmanage modifyvm "$vmname" --vrde on
vboxmanage modifyvm "$vmname" --vrdeproperty VNCPassword=secret
vboxheadless --startvm "$vmname"