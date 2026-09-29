terraform {
  # required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.1.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.5.0"
    }   

  }

  # Remote Backend
  backend "s3" {
    bucket         = "shopverse-dev-tfstate"
    key            = "addon-aws-lbc/terraform.tfstate"
    region         = "us-east-1"
    # encrypt        = true
    use_lockfile   = true   # Enables native S3 state locking (Terraform 1.10+)
  }   

}  # terraform end

provider "aws" {
  region = var.region
}
