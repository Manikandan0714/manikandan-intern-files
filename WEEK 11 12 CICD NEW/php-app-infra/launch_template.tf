resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = data.aws_ami.ecs_optimized.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_profile.name
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.project_name}-cluster >> /etc/ecs/ecs.config
EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [data.aws_security_group.ec2_sg.id]
  }
}
