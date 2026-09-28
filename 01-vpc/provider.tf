terraform {
  # required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }
  }

# Remote Backend
  backend "s3" {}      
}

provider "aws" {
  # AWS region to use for all resources (from variables)
  region = var.region

  default_tags {
    tags = {
      Project     = "ecommerve"
      Env         = "dev"
      ManagedBy   = "Terraform"
    }
}
