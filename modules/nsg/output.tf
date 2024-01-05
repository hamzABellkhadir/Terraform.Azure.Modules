
###
# Outputs
###

output "nsg_id" {
  description = "The unique identifier of the newly created Network Security Group."
  value       = azurerm_network_security_group.nsg.id
}

# EOF
