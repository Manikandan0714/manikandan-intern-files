output "alb_dns" {
  value = aws_lb.alb.dns_name
}
output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
}