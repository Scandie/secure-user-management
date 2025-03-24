terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "tf-state-bckt-ihor"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "tf-lck-table-ihor"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
