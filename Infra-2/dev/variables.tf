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
sg_name = "${var.project}-${var.env}-bastion-sg"
variable "ami_id" {}
variable "public_key_name" {}
