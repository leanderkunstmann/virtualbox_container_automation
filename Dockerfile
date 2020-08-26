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

# Installation of VBOX from Ubuntu Sources (includes VNC, which is not available for Ubuntu via oracle sources)
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

RUN chmod +x run.sh

CMD ["/run.sh"]


# docker run -d --privileged --name vbox -it -v /dev/vboxdrv:/dev/vboxdrv -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp:/tmp -v ~/machines:/machines -p 3389:3389 vboxsystemd2 && docker exec -it vbox ./run.sh
# microk8s kubectl run --image=vboximage vbox --port=3389
#kubectl run vbox --image=localhost:32000/vboximage  --overrides='{"spec": {"template": {"spec": {"containers": [{"name": "vbox", "image": "localhost:32000/vboximage", "securityContext": {"privileged": true} }]}}}}
#-e "vmname="ReactOS 0.4.9"
#-e "remote=VNC"

#docker run --name vbox_http --restart=always -p 80:80 -e VB_HOSTPORT=172.17.0.2:18083  -e VB_noAuth='true'   -d jazzdd/phpvirtualboxdo

#eyJhbGciOiJSUzI1NiIsImtpZCI6InQxZjBuSHFtdXgzWHM0Z0JnZ2lPV0RaX2V4UG0wdDk3aFpwRFkzOTdWZzgifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkZWZhdWx0LXRva2VuLXBnMnA4Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImRlZmF1bHQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI0MTJlN2E4MS00ZWVmLTQxZGYtYjU5MC01YjI2YmVkM2RkY2EiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06ZGVmYXVsdCJ9.DUc3kuSw8c2GhgWgD6yF2OPVFT7sY7V5Q7GlFAG36BzAksy4W9_dDuobiUMqL_nTdGPa2MhgA6iBXlvue8ZSqGNJAjc528JPq_sx0mrOyYoEo9uxRSJm5YSdySsfv-iOjDfGSGjmMn-5t7zmO9u02H5eGSC9elaEZRqX6hrv-nMknd2nktG6sdzxXYYajoWgwZP70CABHj89HXK_AqC-PQfV_oDT4kK-ZeJxaVZYzT-7ns5QKpQE2yD8HOmWE9EbaUf1f4XHEo2Z525fZebYUyq1Xh04JjwsPt5gNHzL_BVD4GDPCgBub-LijFpD5xUNYDM3Z0-g1IO5MHmCNDuDhw

