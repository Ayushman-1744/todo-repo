#!/bin/bash

# Update system packages
sudo yum update -y

sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade

# Install Java (Jenkins requires Java)
sudo dnf install java-17-amazon-corretto -y

# Install Docker in EC-2
yum install docker -y

# Start Docker in EC2
sudo systemctl start docker
sudo systemctl enable docker

# Give docker root permission 
sudo usermod -aG docker jenkins


# Install Jenkins
sudo yum install jenkins -y

# Start Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Restart Jenkins
sudo systemctl restart jenkins

sudo yum install git -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install terraform -y
terraform --version
aws --version
git --version
docker --version
jenkins --version

# Print Jenkins initial admin password
echo "Jenkins Installation Complete!"
echo "To unlock Jenkins, use the following admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
