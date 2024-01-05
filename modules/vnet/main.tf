###
# Terraform vnet
###
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.51.0"
    }
  }
  required_version = ">= 1.5"
}


###
# Resources (Vnet/Subnet)
###

resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

}

module "subnet" {
  for_each                                  = { for index, subnet in var.subnets : index => subnet }
  source                                    = "./modules/subnets"
  resource_group_name                       = var.resource_group_name
  location                                  = var.location
  vnet_name                                 = azurerm_virtual_network.vnet.name
  route_table_id                            = azurerm_route_table.rt.id
  address_range                             = each.value.address_range
  service_endpoints                         = each.value.service_endpoints
  service_delegation                        = each.value.service_delegation
  private_endpoint_network_policies_enabled = each.value.private_endpoint_network_policies_enabled
  name                                      = each.value.name
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

###
# Resources (Route Table)
###

resource "azurerm_route_table" "rt" {
  name                          = "rt-${var.name}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  disable_bgp_route_propagation = true

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }

}


