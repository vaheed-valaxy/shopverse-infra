variable "project" {}
variable "env" {}
variable "region" { default = "us-east-1" }

variable "remote_state_s3_bucket" {}    # To read VPC and EKS output values
