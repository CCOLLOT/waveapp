terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.AWS_REGION
}

terraform {
  backend "s3" {
    bucket = "webapp-formation-backend"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}