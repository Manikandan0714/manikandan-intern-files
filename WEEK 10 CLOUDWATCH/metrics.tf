resource "aws_cloudwatch_log_metric_filter" "error_counter" {
  name           = "${var.project_name}-error-filter"
  pattern        = "ERROR" # The keyword to search for in logs
  log_group_name = aws_cloudwatch_log_group.app_logs.name

  metric_transformation {
    name      = "ErrorCount"
    namespace = "MyApp/Logs" # Custom namespace for your filtered metrics
    value     = "1"          # Increment metric by 1 for every match
  }
}