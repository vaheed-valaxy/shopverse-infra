terraform {
  # Minimum Terraform CLI version required
  # required_version = ">= 1.12.0"

  # Required providers and version constraints
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"   # "~> 5.0"
    }
  }

  # Remote Backend
  backend "s3" {
    bucket         = "shopverse-dev-tfstate"
    key            = "shopverse-eks-vpc.tfstate"
    region         = "us-east-1"
    # encrypt        = true
    use_lockfile   = true   # Enables native S3 state locking (Terraform 1.10+)
  }
}

provider "aws" {
  # AWS region to use for all resources (from variables)
  region = "us-east-1"     # var.region

  # default_tags {
  #   tags = {
  #     Project     = "shopverse"
  #     Env         = "dev"
  #     ManagedBy   = "terraform"
  #   }
  # }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_ca)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}
