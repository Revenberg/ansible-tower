#!/bin/bash

sudo rm -rf ~/ansible*

date > ~/ansible.log

git clone https://github.com/Revenberg/ansible.git 
git clone https://github.com/Revenberg/ansible-tower.git 

# Configure IP address in "hosts" file. If you have more than one
# Raspberry Pi, add more lines and enter details
i=$(sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
h=$(hostname)

echo "$h ansible_host=$i" >> /home/pi/ansible.log

echo "[tower]" >> /home/pi/ansible/hosts
echo "$i  ansible_connection=ssh ansible_ssh_user=pi ansible_ssh_pass=tower" >> ~/ansible/hosts

cd ~/ansible-tower
ansible-playbook setup.yml >> ~/ansible.log

cat ~/ansible.log
