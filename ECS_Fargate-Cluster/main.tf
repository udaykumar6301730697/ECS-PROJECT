terraform {
  backend "s3" {
    region="us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
