data "aws_caller_identity" "current" {}

data "aws_ami" "ecs_optimized" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}

data "aws_security_group" "alb_sg" {
  name   = "${var.project_name}-alb-sg"
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "ec2_sg" {
  name   = "${var.project_name}-ec2-sg"
  vpc_id = data.aws_vpc.default.id
}
