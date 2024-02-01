#!/bin/bash
EC2-instance on AWS
# Update Repos
#!/bin/bash
yum update -y

yum install -y git

# Install Docker
yum install -y docker
id ec2-user
# Reload a Linux user's group assignments to docker w/o logout
newgrp docker
systemctl status docker.service

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version

