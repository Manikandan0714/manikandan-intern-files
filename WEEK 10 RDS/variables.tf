variable "aws_region" {
  description = "AWS Region to deploy to"
  default     = "us-east-1"
}

variable "my_ip" {
  description = "Your personal Public IP for the whitelist (CIDR format)"
  default     = "45.127.109.146/32"
}

variable "db_username" {
  description = "Master username for the database"
  default     = "admin"
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
  # You will be prompted for this when running 'terraform apply'
}

variable "db_name" {
  description = "The name of the initial database to create"
  default     = "mydb"
}