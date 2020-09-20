#!/bin/sh

if [ "$remote" = "VNC" ]
then
  /usr/bin/supervisord

else
  /run.sh

fi






