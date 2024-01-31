# --- root/Terraform_projects/terraform_two_tier_architecture/main.tf

# ************************************************************
# Description: two-tier architecture with terraform
# - file name: main.tf
# - custom VPC
# - 1 public subnets in different AZs for high availability
# - 1 private subnets in different AZs
# - 1 EC2 t2.micro instance in each public subnet
# ************************************************************

# PROVIDER BLOCK




# VPC BLOCK
# creating VPC
resource "aws_vpc" "custom_vpc" {
   cidr_block       = var.vpc_cidr

   tags = {
      name = "{}-front-end"
   }
}


# public subnet 1
resource "aws_subnet" "public_subnet" {   
   vpc_id            = aws_vpc.custom_vpc.id
   cidr_block        = var.public_subnet
   availability_zone = var.az1

   tags = {
      name = "public_subnet"
   }
}


 

# private subnet 1
resource "aws_subnet" "private_subnet" {   
   vpc_id            = aws_vpc.custom_vpc.id
   cidr_block        = var.private_subnet
   availability_zone = var.az1

   tags = {
      name = "app01-front-end-subnet1"
   }
}


  

# creating internet gateway 
resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.custom_vpc.id

   tags = {
      name = "igw"
   }
}


# creating route table
resource "aws_route_table" "rt" {
   vpc_id = aws_vpc.custom_vpc.id
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
      name = "rt"
  }
}


# tags are not allowed here 
# associate route table to the public subnet 1
resource "aws_route_table_association" "public_rt" {
   subnet_id      = aws_subnet.public_subnet.id
   route_table_id = aws_route_table.rt.id
}





# tags are not allowed here 
# associate route table to the private subnet 1
resource "aws_route_table_association" "private_rt" {
   subnet_id      = aws_subnet.private_subnet.id
   route_table_id = aws_route_table.rt.id
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.custom_vpc.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = aws_vpc.custom_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = aws_vpc.custom_vpc.ipv6_cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = aws_vpc.custom_vpc.ipv6_cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



# INSTANCES BLOCK - EC2 and DATABASE

# user_data = file("install_apache.sh")  
# if used with file option - get multi-line argument error 
# as echo statement is long
# 1st ec2 instance on public subnet 1
resource "aws_instance" "ec2_1" {
   ami                     = var.ec2_instance_ami
   instance_type           = var.ec2_instance_type
   availability_zone       = var.az1
   subnet_id               = aws_subnet.public_subnet.id
   vpc_security_group_ids  = [aws_security_group.allow_tls.id] 
   user_data               = <<EOF
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

# install golang
yum install golang -y

#install kind
go install sigs.k8s.io/kind@v0.20.0.

       EOF

   tags = {
      name = "ec2_1"
  }
}

# 2nd ec2 instance on public subnet 1
resource "aws_instance" "ec2_2" {
   ami                     = var.ec2_instance_ami
   instance_type           = var.ec2_instance_type
   availability_zone       = var.az1
   subnet_id               = aws_subnet.public_subnet.id
   vpc_security_group_ids  = [aws_security_group.allow_tls.id] 
   user_data               = <<EOF
#!/bin/bash
EC2-instance on AWS
# Update Repos
#!/bin/bash
yum update -y
       EOF

   tags = {
      name = "ec2_2"
  }
}

# 3rd ec2 instance on public subnet 1
resource "aws_instance" "ec2_3" {
   ami                     = var.ec2_instance_ami
   instance_type           = var.ec2_instance_type
   availability_zone       = var.az1
   subnet_id               = aws_subnet.public_subnet.id
   vpc_security_group_ids  = [aws_security_group.allow_tls.id] 
   user_data               = <<EOF
#!/bin/bash
EC2-instance on AWS
# Update Repos
#!/bin/bash
yum update -y
       EOF

   tags = {
      name = "ec2_3"
  }
}