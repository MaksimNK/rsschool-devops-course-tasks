output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}
output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "IDs of public subnets"
}
output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "IDs of private subnets"
}
output "bastion_public_ip" {
  value       = aws_instance.bastion.public_ip
  description = "Public IP of bastion host"
}
