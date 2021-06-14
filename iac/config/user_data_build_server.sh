#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

yum update -y

# Java installation
sudo amazon-linux-extras enable corretto8
sudo yum install java-1.8.0-amazon-corretto -y
