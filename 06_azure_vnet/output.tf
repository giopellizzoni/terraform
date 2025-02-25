output "subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "The ID of the subnet on azure"
}

output "security_group_id" {
  value       = azurerm_network_security_group.nsg.id
  description = "The ID of the security group on azure"
}
