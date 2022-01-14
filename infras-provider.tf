provider "aws" {
  region  = var.aws_region
}

#terraform backend will be passed dynamically
terraform {
  backend "s3" {}

}