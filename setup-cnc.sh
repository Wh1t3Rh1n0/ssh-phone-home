#!/bin/bash

### SETUP C&C ###

# Create the drop box user account
useradd -m -r -s /bin/false dropbox
mkdir /home/dropbox/.ssh
touch /home/dropbox/.ssh/authorized_keys
chown -R dropbox /home/dropbox

# Import the drop box's public SSH key or prompt for it if not found
if [ -e '/opt/ssh-phone-home/id_rsa.pub' ] ; then
    cat '/opt/ssh-phone-home/id_rsa.pub' >> /home/dropbox/.ssh/authorized_keys
else
    echo You must manually add the drop box user\'s public ssh key to the 
    echo authorized_keys file.
    echo Example: cat id_rsa.pub > /home/dropbox/.ssh/authorized_keys
fi

# Make the SSH service listen on port 443 in addition to 22
sed -i 's/Port 22/Port 22\nPort 443/g' /etc/ssh/sshd_config

# Start the SSH service
service ssh start
