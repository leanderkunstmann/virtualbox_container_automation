FROM jrei/systemd-ubuntu
MAINTAINER Leander Kunstmann <leander.kunstmann@gmx.de>

ENV DEBIAN_FRONTEND noninteractive

#INSTALL VIRTUALBOX 6.1
RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y gnupg2 \
  && apt -y install systemd \
  && apt-get install net-tools \
  && apt-get install -y supervisor \
  && yes | apt-get install python \
  && apt -y install software-properties-common \
  && rm -rf /var/lib/apt/lists/*

# Installation of VBOX from official Sources
#RUN wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
#RUN sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian focal contrib" >> /etc/apt/sources.list.d/virtualbox.list'
#RUN apt-get update
#RUN apt-get install -y virtualbox-6.1|| /bin/true
#RUN apt-get install -y -f

# Installation of VBOX from Ubuntu Sources (includes VNC, which is not available for Ubuntu via oracle sources)
RUN apt-get update \
 && yes | apt-get install virtualbox \
 && rm -rf /var/lib/apt/lists/*

#R Installation of noVNC Webclient Layer
RUN mkdir -p novnc/utils/websockify \
    && wget -qO- https://github.com/novnc/noVNC/archive/v1.0.0.tar.gz | tar xz --strip 1 -C novnc \
    && wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | tar xz --strip 1 -C novnc/utils/websockify \
    && chmod +x -v novnc/utils/*.sh \
    && ln -s novnc/vnc_lite.html novnc/index.html


# INSTALL Virtualbox Extension Pack
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie;" https://download.virtualbox.org/virtualbox/6.1.12/Oracle_VM_VirtualBox_Extension_Pack-6.1.12.vbox-extpack ; \
    yes | VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.1.12.vbox-extpack ; \
    rm Oracle_VM_VirtualBox_Extension_Pack-6.1.12.vbox-extpack ;

EXPOSE 3389/tcp
EXPOSE 5901


ENV vmname "Xenix 386 2.3.4q"
ENV remote "Oracle VM VirtualBox Extension Pack"

VOLUME /machines

COPY run.sh /
COPY wrapper.sh /
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x run.sh
RUN chmod +x wrapper.sh
RUN chmod +x /etc/supervisor/conf.d/supervisord.conf

#CMD ["/usr/bin/supervisord"]
CMD ["/wrapper.sh"]

#docker run --privileged --name vbox -it -v /dev/vboxdrv:/dev/vboxdrv -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp:/tmp -v ~/machines:/machines -p 3389:3389 -p 5091:5091 -e remote="VNC" vboxsystemd2
# docker run -d --privileged --name vbox -it -v /dev/vboxdrv:/dev/vboxdrv -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp:/tmp -v ~/machines:/machines -p 3389:3389 vboxsystemd2 && docker exec -it vbox ./run.sh
# microk8s kubectl run --image=vboximage vbox --port=3389
#kubectl run vbox --image=localhost:32000/vboximage  --overrides='{"spec": {"template": {"spec": {"containers": [{"name": "vbox", "image": "localhost:32000/vboximage", "securityContext": {"privileged": true} }]}}}}
#-e "vmname="ReactOS 0.4.9"
#-e "remote=VNC"
