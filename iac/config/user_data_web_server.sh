#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

yum update -y

# Docker installation
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
