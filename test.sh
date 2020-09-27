#!/bin/bash

Declare already_tested = 'DilOS' 'HAL91' "OpenBSD 6.5 (Fvwm)" 'OPENSTEP 4.2' 'OS2 1.30 (Micorsoft)' 'OS2-W4''TrueOS 18.12 stable (Mate)' 'ReactOS 0.4.9' 'Unix System V R4' 'Win NT 3.51' 'Win NT 4 (clean)' 'WIN3.1 (SND, SVGA, NET)' 'Xenix 386 2.3.4q' 'CPM-86 1.1'  'DOS_2.10' 'DOS_3.30 Win2' 'DOS_622-Win311'
FILES=('sol-11_4-vbox' 'DR-DOS8')
echo "$i is tested"
for i in "${FILES[@]}"

do
  docker stop vbox
  docker rm vbox

  echo "$i is tested"
  echo "$i is tested"
  echo "$i is tested"
    docker run --privileged --name vbox -it -v /dev/vboxdrv:/dev/vboxdrv -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp:/tmp -v ~/machines:/machines -p 3389:3389 -p 5091:5091 -e remote="Oracle VM VirtualBox Extension Pack" -e vmname="$i" vboxsystemd2
    docker rm vbox
    docker run --privileged --name vbox -it -v /dev/vboxdrv:/dev/vboxdrv -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp:/tmp -v ~/machines:/machines -p 3389:3389 -p 5091:5091 -e remote="VNC" -e vmname="$i" vboxsystemd2
    # rollback IFS value
done