FROM jrei/systemd-ubuntu
MAINTAINER Leander Kunstmann <leander.kunstmann@gmx.de>

ENV DEBIAN_FRONTEND noninteractive
EXPOSE 18083/tcp
EXPOSE 18083/udp




#INSTALL VIRTUALBOX 6.1
RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y gnupg2 \
  &&     apt -y install systemd \
  &&     apt -y install software-properties-common \
  && rm -rf /var/lib/apt/lists/*
RUN wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
RUN sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian focal contrib" >> /etc/apt/sources.list.d/virtualbox.list'
RUN apt-get update
RUN apt-get install -y virtualbox-6.1|| /bin/true
RUN apt-get install -y -f


# INSTALL Virtualbox Extension Pack
RUN VBOX_VERSION=`dpkg -s virtualbox-6.1 | grep '^Version: ' | sed -e 's/Version: \([0-9\.]*\)\-.*/\1/'` ; \
    wget http://download.virtualbox.org/virtualbox/${VBOX_VERSION}/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_VERSION}.vbox-extpack ; \
    VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-${VBOX_VERSION}.vbox-extpack ; \
    rm Oracle_VM_VirtualBox_Extension_Pack-${VBOX_VERSION}.vbox-extpack



#docker run --name=vboxcontainer -it -v /dev/vboxdrv:/dev/vboxdrv -v ~/machines:/machines virtualboxcontainer
    #docker run -d --privileged --name vbox --network=host --device /dev/vboxdrv:/dev/vboxdrv -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp:/tmp -v ~/machines:/machines -it vboxsystemd
#docker run --name vbox_http --restart=always \
 #    -p 79:79
 #    -e VB_HOSTPORT=172.17.0.2:18083
 #    -e ID_NAME=virtualboxcontainer
 #    -e VB_USER=admin
 #    -e VB_PW='admin'
#vboxmanage setproperty machinefolder /machine
#VBoxManage modifyvm "ReactOS 0.4.9" --vrde on

# -e VB_NAME=Server1 -e VB_USER=leander -e VB_PW='Mallorca7!'

#docker run --name vbox_http --restart=always -p 80:80 -e VB_HOSTPORT=172.17.0.2:18083  -e VB_noAuth='true'   -d jazzdd/phpvirtualbox