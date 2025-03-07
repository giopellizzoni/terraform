terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
  }

  backend "s3" {
    bucket = "giopellizzoni-remote-state"
    key    = "workspaces/terraform.tfstate"
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
