resource "aws_launch_template" "app_lt" {
  name_prefix   = "ror-template-"
  image_id      = var.my_golden_ami
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.ssm_profile.name
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              NEW_DB_HOST="${split(":", aws_db_instance.default.endpoint)[0]}"
              NEW_DB_PASS="${var.db_password}"
              CONFIG_FILE="/var/www/demo_app/config/database.yml"
              RAILS_CONFIG="/var/www/demo_app/config/environments/production.rb"
              APPLICATION_RB="/var/www/demo_app/config/application.rb"

              sed -i "s/^  host:.*/  host: $NEW_DB_HOST/" $CONFIG_FILE
              sed -i "s/^  password:.*/  password: $NEW_DB_PASS/" $CONFIG_FILE
              
              # Add host configuration to application.rb (more reliable)
              echo "" >> $APPLICATION_RB
              echo "# Disable host checking for ALB" >> $APPLICATION_RB
              echo "Rails.application.configure do" >> $APPLICATION_RB
              echo "  config.hosts.clear" >> $APPLICATION_RB
              echo "end" >> $APPLICATION_RB

              chown -R ubuntu:ubuntu /var/www/demo_app
              cd /var/www/demo_app
              su - ubuntu -c "bundle exec rails db:create"
              su - ubuntu -c "bundle exec rails db:migrate"
              
              systemctl restart rails_app
              sleep 5
              systemctl restart rails_app
              EOF
  )
}

resource "aws_autoscaling_group" "app_asg" {
  name                = "ror-asg"
  min_size            = 1
  max_size            = 3
  desired_capacity    = 1
  vpc_zone_identifier = data.aws_subnets.default.ids
  target_group_arns   = [aws_lb_target_group.app_tg.arn]

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "cpu_policy" {
  name                   = "target-tracking-cpu-20"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.app_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 20.0
  }
}