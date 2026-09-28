# vpc
variable "project" {}
variable "env" {}
variable "region" {}

# Common Tags
common_tags = {
    Project     = var.project
    Environment = var.env
    Terraform   = "True"
  }

# Bastion
variable "ami_id" {}
variable "public_key_name" {}
