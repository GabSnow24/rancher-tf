output "web_sg" {
  value       = aws_security_group.web
  description = "Web SG"
  depends_on = [
    aws_security_group.web
  ]
}