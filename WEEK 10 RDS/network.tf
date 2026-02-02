# --- Data Sources: Get Default VPC ---
data "aws_vpc" "default" {
  default = true
}

# --- Security Group ---
resource "aws_security_group" "rds_sg" {
  name        = "rds-workbench-access"
  description = "Allow MySQL access from specific IP"
  vpc_id      = data.aws_vpc.default.id

  # INGRESS: Allow MySQL (3306) from your specific IP
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
    description = "Access from my Public IP"
  }

  # EGRESS: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-security-group"
  }
}