#!/bin/bash

sudo delgroup -remove-home tower
sudo deluser tower

sudo chmod 4511 /usr/bin/passwd

u=$(id tower | grep uid | wc -l)
if (( "$u" == "0" )); then
        sudo useradd -m -d /home/tower -s /bin/bash -p '' tower
        sudo sh -c "echo 'tower:tower'  | sudo chpasswd  "
        sudo sh -c "echo 'tower ALL=(ALL:ALL)NOPASSWD: ALL' >> /etc/sudoers"
        sudo adduser tower sudo
fi

git config --global user.email "sander@revenberg.info"
git config --global user.name "Sander Revenberg"

git config --global credential.helper 'cache --timeout 14400'
git add -A *
git commit -m "updates"
git push -u origin master

apt-get update 
apt-get autoremove

apt-get install git -y 

# Install Ansible and Git on the machine.
apt-get install python-pip git python-dev sshpass -y
pip install ansible 
pip install markupsafe 

exit
