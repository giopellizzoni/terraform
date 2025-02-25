output "vm_ip" {
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
  description = "The public IP address of the VM"

}
