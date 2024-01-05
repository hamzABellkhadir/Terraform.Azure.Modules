<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.51.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subnet"></a> [subnet](#module\_subnet) | ./modules/subnets | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_route_table.rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | (Required) IP Address space used for this Virtual Network. | `set(string)` | n/a | yes |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional) List of DNS servers used for the Virtual Network. | `set(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The Azure region in which resources will be deployed. | `string` | `"westeurope"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Azure Virtual Network. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Azure Resource Group. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional) List of Subnets to be attached to this Virtual Network. | <pre>list(object({<br>    address_range                             = set(string)<br>    service_endpoints                         = optional(set(string))<br>    name                                      = string<br>    private_endpoint_network_policies_enabled = bool<br>    service_delegation = optional(map(object({<br>      name   = string<br>      action = set(string)<br>    })))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table_id"></a> [route\_table\_id](#output\_route\_table\_id) | The id of the generated Route Table. |
| <a name="output_subnets_id"></a> [subnets\_id](#output\_subnets\_id) | A list of ids for the generated Subnets. |
| <a name="output_subnets_name"></a> [subnets\_name](#output\_subnets\_name) | A list of names for the generated Subnets. |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The id of the generated Virtual Network. |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | The name of the generated Virtual Network. |

## Example

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.41.0"
    }
  }
  required_version = ">= 1.5"
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  features {}
}

variable "tenant_id" {
  description = "(Required) tenant id"
  type        = string
}
variable "subscription_id" {
  description = "(Required) subscription ID"
  type        = string
}
variable "resource_group_name" {
  type    = string
  default = "we-rg-test-001"
}


variable "location" {
  type    = string
  default = "westeurope"
}


# Location West Europe

module "vnet" {
  source              = "../"
  name                = "we-vnet-webapp-0001"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = ["192.168.0.0/24"]
  subnets = [
    {
      name                                      = "we-subnet-webapp-0001"
      address_range                             = ["192.168.0.0/24"]
      private_endpoint_network_policies_enabled = true
      service_endpoints                         = ["Microsoft.Storage", "Microsoft.KeyVault"]
      service_delegation                        = {}
    }
  ]
}

# EOF
```
<!-- END_TF_DOCS -->