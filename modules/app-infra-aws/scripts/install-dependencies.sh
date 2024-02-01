#!/bin/bash
EC2-instance on AWS
# Update Repos
#!/bin/bash
yum update -y

# Install Docker
yum install -y docker
id ec2-user
# Reload a Linux user's group assignments to docker w/o logout
newgrp docker
systemctl status docker.service

