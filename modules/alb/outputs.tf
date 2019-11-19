output "lb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "target_group_arns_http" {
  value = aws_lb_target_group.lb-tg-http.*.arn
}

output "target_group_arns_https" {
  value = aws_lb_target_group.lb-tg-https.*.arn
}
