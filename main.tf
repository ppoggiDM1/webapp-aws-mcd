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

terraform {
   required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.33.0"
    }

  }
  required_version = "~> 1.3"
}

provider "aws" {
  region  = "eu-central-1"
}


module "app-infra-aws" {
  source = "./modules/app-infra-aws"

  application_name = var.appname

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
} 
