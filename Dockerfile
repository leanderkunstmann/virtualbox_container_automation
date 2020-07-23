FROM ubuntu:20.04
MAINTAINER Leander Kunstmann <leander.kunstmann@gmx.de>

ENV DEBIAN_FRONTEND noninteractive
ENV VRDE on

#INSTALL VIRTUALBOX 6.1
RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y gnupg2 \
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

# MOUNTING the vbox driver to the host
VOLUME /dev/vboxdrv


#vboxmanage mount shared folder with host, import vm there, create rdp/vnc connect

