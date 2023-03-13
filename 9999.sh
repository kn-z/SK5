#!/bin/bash
sudo -i
sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo root:9PRZbl9I84Hbo1xH7h | sudo chpasswd
systemctl restart sshd

wget --version||yum install wget -y||apt-get install wget -y
/usr/bin/neko-status -v||(wget https://github.com/nkeonkeo/nekonekostatus/releases/download/v0.1/neko-status -O /usr/bin/neko-status && chmod +x /usr/bin/neko-status)
systemctl stop nekonekostatus
mkdir /etc/neko-status/
echo "key: a230470e-ed3a-4ece-b796-35f15012a662
port: 9999
debug: false" > /etc/neko-status/config.yaml
systemctl stop nekonekostatus
echo "[Unit]
Description=nekonekostatus

[Service]
Restart=always
RestartSec=5
ExecStart=/usr/bin/neko-status -c /etc/neko-status/config.yaml

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/nekonekostatus.service
systemctl daemon-reload
systemctl start nekonekostatus
systemctl enable nekonekostatus
yum install -y lsof
apt install -y lsof
echo 'success'
