output "log_group_name" {
  description = "The name of the created CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.app_logs.name
}

output "alarm_arn" {
  description = "The ARN of the CPU High Alarm"
  value       = aws_cloudwatch_metric_alarm.cpu_high_alarm.arn
}

output "metric_filter_name" {
  description = "The name of the log metric filter"
  value       = aws_cloudwatch_log_metric_filter.error_counter.name
}