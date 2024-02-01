# --- root/Terraform_projects/terraform_two_tier_architecture/variables.tf


variable "application_name" {
  description = "Name of the application. Must be unique."
  type        = string
}

variable "tags" {
  description = "Tags to set on the application."
  type        = map(string)
  default     = {}
}

# custom VPC variable
variable "vpc_cidr" {
  description = "custom vpc CIDR notation"
  type        = string
  default     = "10.0.0.0/16"
}


# public subnet 1 variable
variable "public_subnet" {
  description = "public subnet CIDR notation"
  type        = string
  default     = "10.0.1.0/24"
}



# private subnet 1 variable
variable "private_subnet" {
  description = "private subnet 2 CIDR notation"
  type        = string
  default     = "10.0.2.0/24"
}


# AZ 1
variable "az1" {
  description = "availability zone 1"
  type        = string
  default     = "us-east-1a"
}


# AZ 2
variable "az2" {
  description = "availability zone 2"
  type        = string
  default     = "us-east-1b"
}


# ec2 instance ami for Linux
variable "ec2_instance_ami" {
  description = "ec2 instance ami id"
  type        = string
  default     = "ami-0277155c3f0ab2930"


}


# ec2 instance type
variable "ec2_instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "nof_frontend_nodes"{
  description = "Front End nodes"
  type        = number 
  default     =   1
}

variable "nof_backend_nodes"{
  description = "BackEnd nodes"
  type        = number 
  default     =   1
}

 
