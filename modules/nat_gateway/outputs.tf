output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = aws_nat_gateway.this.id
}

output "elastic_ip_id" {
  description = "The ID of the Elastic IP."
  value       = aws_eip.this.id
}
