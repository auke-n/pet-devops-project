#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

#Install Jenkins, Java, Git

sudo yum update -y

# Java installation
sudo amazon-linux-extras enable corretto8
sudo yum install java-1.8.0-amazon-corretto-devel -y

# Jenkins installation
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y
systemctl daemon-reload
systemctl start jenkins
systemctl enable jenkins

# Git installation
sudo yum install git -y

#Create a SWAP-file
sudo su
dd if=/dev/zero of=/swapfile count=3072 bs=1MiB
chmod 600 /swapfile
mkswap /swapfile
swapon  /swapfile
echo "/swapfile   swap    swap    sw  0   0" >> /etc/fstab
mount -a