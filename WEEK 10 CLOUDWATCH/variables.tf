variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "cw-demo"
}

variable "instance_id" {
  description = "The EC2 Instance ID to monitor (defaults to a dummy ID for demonstration)"
  type        = string
  default     = "i-1234567890abcdef0" 
}