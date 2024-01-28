
resource "aws_instance" "ec2_2" {
   ami                     = var.ec2_instance_ami
   instance_type           = var.ec2_instance_type
   availability_zone       = var.az1
   subnet_id               = aws_subnet.private_subnet.id
   user_data               = <<EOF
       #!/bin/bash
       yum update -y
       wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm 
       dnf install mysql80-community-release-el9-1.noarch.rpm -y
       dnf install mysql-community-server -y
       systemctl start mysqld
       systemctl enable mysqld

       yum install -y httpd
       systemctl start httpd
       systemctl enable httpd
       EC2AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
       echo '<center><h1>This Amazon EC2 instance is located in Availability Zone:AZID </h1></center>' > /var/www/html/index.txt
       sed"s/AZID/$EC2AZ/" /var/www/html/index.txt > /var/www/html/index.html
       EOF

   tags = {
      name = "ec2_2"
  }
}
