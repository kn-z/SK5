#!/bin/bash
sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config 
sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config 
echo "root:9PRZbl9I84Hbo1xH7h" | sudo chpasswd 
sudo systemctl restart sshd
