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

module "network" {
  source = "./network"

  environment = "development"
  cidr_vpc    = "10.0.0.0/16"
  cidr_subnet = "10.0.0.0/24"

}