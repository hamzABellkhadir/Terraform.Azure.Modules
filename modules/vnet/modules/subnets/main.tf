###
# Terraform
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
# Resources
###

resource "azurerm_subnet" "subnet" {
  name                                      = var.name
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = var.vnet_name
  address_prefixes                          = var.address_range
  private_endpoint_network_policies_enabled = var.private_endpoint_network_policies_enabled
  service_endpoints                         = var.service_endpoints

  dynamic "delegation" {
    for_each = var.service_delegation

    content {
      name = delegation.key

      service_delegation {
        name    = delegation.value.name
        actions = delegation.value.action
      }
    }

  }
}

resource "azurerm_subnet_route_table_association" "rt" {
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = var.route_table_id
}
# EOF
