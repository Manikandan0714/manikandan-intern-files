provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment = "FreeTier-Lab"
      Project     = "Terraform-CloudWatch-Demo"
      ManagedBy   = "Terraform"
    }
  }
}