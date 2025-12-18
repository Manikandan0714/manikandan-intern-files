resource "aws_cloudwatch_log_group" "app_logs" {
  # Naming the log group. Using /aws/ ensures it looks like a standard path.
  name = "/aws/free-tier/${var.project_name}/app-logs"

  # CRITICAL FOR FREE TIER:
  # Expire logs after 7 days to avoid long-term storage charges.
  retention_in_days = 7

  tags = {
    Purpose = "FreeTierLearning"
  }
}