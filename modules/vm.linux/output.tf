###
# Outputs
###

output "vm_id" {
  description = "The unique identifier of the virtual machine."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "admin_account" {
  description = "The admin username for the virtual machine."
  value       = var.admin_username
}

output "network_interface_id" {
  description = "The id of the Network Interface associated with the virtual machine."
  value       = azurerm_network_interface.nic.id
}

output "network_interface_ip" {
  description = "The private IP address of the Network Interface."
  value       = azurerm_network_interface.nic.private_ip_address
}

output "admin_password" {
  description = "Auto-generated admin password for the virtual machine."
  value       = random_password.pass.result
}

# EOF
