terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.48.0"
    }
  }
  backend "s3" {
    bucket         = "ecs-devops"
    key            = "ecs-devops.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "ecs-devops-tf-state-lock"
  }
}

provider "aws" {
  region = var.region
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"

  common_tags = {
    Environment = terraform.workspace
    project     = var.project
    owner       = var.contact
    ManagedBy   = "Terraform"
  }
}

data "aws_region" "current" {

}