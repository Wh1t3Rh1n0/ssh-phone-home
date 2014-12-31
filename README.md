This project was created in order to quickly create Kali Linux based drones
built on inexpensive hardware such as a Raspberry Pi, and then deploy those
drones during physical penetration tests at client sites.

Anything that runs Kali should work with these scripts just fine.


Description
===========
These scripts setup one Kali machine (the drone) to phone-home to another
Kali machine (the C&C) over SSH on port 443. Port 2222 on the C&C is then
forwarded to port 22 on the drone, allowing you to SSH into the drone through
the reverse tunnel and wreak havoc... er... pentest the target network. =P

By default, the drone will attempt an outgoing SSH connection to port 443 every
5 minutes.


Install instructions
====================
Install Kali on your main computer (C&C), and your drone (the one you will
leave plugged in to the target network). As always, be sure to change the root
password on both machines so that it is not the default.

*All scripts should be run as root on both machines.*

Download the necessary files to each machine (both the drone and C&C).
```
cd /opt
git clone https://github.com/Wh1t3Rh1n0/ssh-phone-home
```

Modify /opt/ssh-phone-home/phone-home.sh to point to your C&C's IP/hostname.

Example:
```
CNC_IP=64.233.176.138
```

Setup the drone by running the setup script on that machine:
```
bash /opt/ssh-phone-home/setup-drone.sh
```

Copy the drone's public SSH key to /opt/ssh-phone-home/id_rsa.pub on the C&C.

Setup the C&C server by running the C&C setup script on that machine:
```
bash /opt/ssh-phone-home/setup-cnc.sh
```

This script will make the following changes to your C&C machine:
* Create the non-root user "drone", that the drone will connect as.
* Import drone's public SSH key for SSH login without a password.
* Configure SSH to run on port 443 as well as the default port 22.


C&C Command Reference
=====================
These commands come in handy after you have everything setup and are
working from the C&C server.

Start the SSH service:
```
service ssh start
```

Enable SSH service start at boot:
```
update-rc.d ssh enable
```

Check for current drone connections:
```
netstat -antp | grep ":443.\+ESTABLISHED.\+/sshd"
```

Watch for incoming drone connections:
```
watch 'netstat -antp | grep ":443.\+ESTABLISHED.\+/sshd"'
```

Close the connection from a drone.

Where ####/sshd in output from the previous command:
```
kill ####
```

Login to the drone:
```
ssh root@localhost -p 2222
```
    
