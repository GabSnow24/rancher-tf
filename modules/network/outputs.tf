output "vpc_id" {
  value       = aws_vpc.k8s-main.id
  description = "VPC ID"
  depends_on = [
    aws_vpc.k8s-main
  ]
}

output "public_subnet_1" {
  value       = aws_subnet.public_subnet_1
  description = "Subnet 1"
  depends_on = [
    aws_subnet.public_subnet_1
  ]
}

output "public_subnet_2" {
  value       = aws_subnet.public_subnet_2
  description = "Subnet 2"
  depends_on = [
    aws_subnet.public_subnet_2
  ]
}


