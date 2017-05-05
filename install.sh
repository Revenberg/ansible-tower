#!/bin/bash

if [ $# -ne 1 ]; then
    echo $0: usage: ./install.sh  password
    return 0
fi

cd  ~/tower
git config --global credential.helper 'cache --timeout 14400'
git add -A *
git commit -m "updates"
git push -u origin master








sudo rm -rf /home/pi/ansible*

date > ~/ansible.log
sudo apt-get update 
sudo apt-get autoremove

sudo apt-get install git -y 

# Install Ansible and Git on the machine.
sudo apt-get install python-pip git python-dev sshpass -y
sudo pip install ansible 
sudo pip install markupsafe 

cd ~
git clone https://github.com/Revenberg/ansible.git 
git clone https://github.com/Revenberg/ansible-tower.git 

# Configure IP address in "hosts" file. If you have more than one
# Raspberry Pi, add more lines and enter details
i=$(sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
h=$(hostname)

echo "$h ansible_host=$i" >> /home/pi/ansible.log

echo "[tower]" >> /home/pi/ansible/hosts
echo "$i  ansible_connection=ssh ansible_ssh_user=pi ansible_ssh_pass="$1 >> ~/ansible/hosts

cd ~/ansible-tower
ansible-playbook setup.yml >> ~/ansible.log
