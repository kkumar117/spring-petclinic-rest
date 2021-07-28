#!/bin/bash
set -e

#update packages with security fixes
sudo yum -y --security update

# configure SSHD
sudo sed -i '/^PermitRootLogin/s/yes/no/' /etc/ssh/sshd_config
echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config >/dev/null

#sudo mv /tmp/trusted-user.pem /etc/ssh/trusted-user-ca-keys.pem
#echo "TrustedUserCAKeys /etc/ssh/trusted-user.pem" | sudo tee -a /etc/ssh/sshd_config >/dev/null

#maven
sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
#installing
sudo yum install -y apache-maven -y

#install java 8
sudo yum install java-1.8.0-devel -y
