output "db_endpoint" {
  description = "The endpoint URL for MySQL Workbench"
  value       = aws_db_instance.my_db.endpoint
}

output "db_username" {
  description = "The master username"
  value       = aws_db_instance.my_db.username
}