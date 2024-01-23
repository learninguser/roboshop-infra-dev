terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.32.1"
    }
  }

  backend "s3" {
    bucket         = "learninguser"
    key            = "sg"
    region         = "us-east-1"
    dynamodb_table = "terraform_lock"
  }
}

provider "aws" {
  # Configuration options
  # you can give access key and secret key here, but security problem
  region = "us-east-1"
}