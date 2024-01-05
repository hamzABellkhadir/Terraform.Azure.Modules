###
# Outputs
###

output "route_table_id" {
  value       = azurerm_route_table.rt.id
  description = "The id of the generated Route Table."
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The name of the generated Virtual Network."
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The id of the generated Virtual Network."
}

output "subnets_id" {
  value = [
    for subnet in module.subnet : subnet.subnet_id
  ]
  description = "A list of ids for the generated Subnets."
}

output "subnets_name" {
  value = [
    for subnet in module.subnet : subnet.subnet_name
  ]
  description = "A list of names for the generated Subnets."
}
