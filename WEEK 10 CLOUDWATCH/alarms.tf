resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  alarm_name          = "${var.project_name}-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300" # 300s = 5 min. Must use 300s for Free Tier Basic Monitoring.
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Triggered when EC2 CPU exceeds 80%"
  actions_enabled     = false # Set to true if you add SNS later

  # Defines which specific resource to monitor
  dimensions = {
    InstanceId = var.instance_id
  }
}