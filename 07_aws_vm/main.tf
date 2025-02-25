terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.60.0"
    }
  }

  backend "s3" {
    bucket = "giopellizzoni-remote-state"
    key    = "aws-vm/terraform.tfstate"
    region = "us-east-2"
  }
}


provider "aws" {
  region = "us-east-2"

  default_tags {
    tags = {
      managed_by = "terraform"
      owner      = "giopellizzoni"
    }
  }

}


data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "giopellizzoni-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-2"
  }
}
