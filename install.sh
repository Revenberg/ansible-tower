#!/bin/bash

cd  ~/ansible-tower
git config --global credential.helper 'cache --timeout 14400'
git add -A *
git commit -m "updates"
git push -u origin master

#sudo rm -rf /home/pi/ansible*

date > ~/ansible.log
sudo apt-get update 
sudo apt-get autoremove

sudo apt-get install git -y 

# Install Ansible and Git on the machine.
sudo apt-get install python-pip git python-dev sshpass -y
sudo pip install ansible 
sudo pip install markupsafe 

cd ~
git clone https://github.com/Revenberg/ansible-tower.git 

cd ~/ansible-tower
ansible-playbook setup.yml >> ~/ansible.log
