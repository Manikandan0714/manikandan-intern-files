resource "aws_sns_topic" "alerts" {
  name = "${local.app_name}-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${local.app_name}"
  retention_in_days = 7

  tags = {
    Name = "${local.app_name}-logs"
  }
}
