output "alb_dns_name" {
  value       = aws_lb.app_alb.dns_name
  description = "The public URL of your Load Balancer"
}