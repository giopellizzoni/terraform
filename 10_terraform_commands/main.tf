terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }

  backend "s3" {
    bucket = "giopellizzoni-remote-state"
    key    = "commands/terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      owner      = "giopellizzoni"
      managed_by = "terraform"
    }
  }
}