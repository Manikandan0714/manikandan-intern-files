# versions.tf

terraform {
  required_version = ">= 1.9.0" # Ensures you use a recent, secure Terraform CLI

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"      # Uses the latest major version 6 of the AWS Provider
    }
  }
}