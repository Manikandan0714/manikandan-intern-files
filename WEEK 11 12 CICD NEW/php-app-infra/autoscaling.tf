resource "aws_autoscaling_group" "ecs_asg" {
  name                = "${var.project_name}-asg"
  min_size            = 1
  max_size            = 4
  desired_capacity    = 2
  vpc_zone_identifier = data.aws_subnets.all.ids

  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSCluster"
    value               = "${var.project_name}-cluster"
    propagate_at_launch = true
  }
}
