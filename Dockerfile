FROM jrei/systemd-ubuntu
MAINTAINER Leander Kunstmann <leander.kunstmann@gmx.de>

ENV DEBIAN_FRONTEND noninteractive
EXPOSE 18083/tcp
EXPOSE 18083/udp

#INSTALL VIRTUALBOX 6.1
RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y gnupg2 \
  && apt -y install systemd \
  && apt -y install software-properties-common \
  && rm -rf /var/lib/apt/lists/*
# Installation of VBOX from official Sources
#RUN wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
#RUN sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian focal contrib" >> /etc/apt/sources.list.d/virtualbox.list'
#RUN apt-get update
#RUN apt-get install -y virtualbox-6.1|| /bin/true
#RUN apt-get install -y -f

# Installation of VBOX from Ubuntu Sources (includes VNC, which is not available for Ubuntu over
RUN apt-get update \
 && yes | apt-get install virtualbox \
 && rm -rf /var/lib/apt/lists/*






# INSTALL Virtualbox Extension Pack
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie;" https://download.virtualbox.org/virtualbox/6.1.12/Oracle_VM_VirtualBox_Extension_Pack-6.1.12.vbox-extpack ; \
    yes | VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.12.vbox-extpack ; \
    rm Oracle_VM_VirtualBox_Extension_Pack-6.1.12.vbox-extpack ;

EXPOSE 3389/tcp

ENV vmname "Xenix 386 2.3.4q"
ENV remote "Oracle VM VirtualBox Extension Pack"

VOLUME /machines

COPY run.sh /
 #chmod +x run.sh

RUN chmod +x run.sh

#CMD "./run.sh --vmname $vmname" && "/bin/sh -c"

#\ vboxmanage modifyvm $vmname --vrde on \ VBoxManage setproperty vrdeextpack VNC \ vboxmanage modifyvm $vmname --vrdeproperty VNCPassword=secret \ vboxheadless --startvm $vmname



# docker run -d --privileged --name vbox -it --device /dev/vboxdrv:/dev/vboxdrv -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp:/tmp -v ~/machines:/machines -p 3389:3389 vboxsystemd2 && docker exec -it vbox ./run.sh
#-e "vmname="ReactOS 0.4.9"
#-e "remote=VNC"

#docker run --name vbox_http --restart=always -p 80:80 -e VB_HOSTPORT=172.17.0.2:18083  -e VB_noAuth='true'   -d jazzdd/phpvirtualbox
