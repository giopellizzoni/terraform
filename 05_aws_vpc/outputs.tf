output "subnet_id" {
  description = "Id da subnet criada na AWS"
  value       = aws_subnet.subnet.id
}

output "security_group_id" {
  description = "Id do security group criado na AWS"
  value       = aws_security_group.sg.id
}
