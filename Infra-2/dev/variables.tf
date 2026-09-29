# Common
variable "project" {}
variable "env" {}
variable "region" {}

# Bastion
variable "ami_id" {}
variable "public_key_name" {}

# Secrets Manager
variable "aws_secret_name" {}
variable "db_username" {}
variable "db_password" {}
variable "jwt_secret" {}
