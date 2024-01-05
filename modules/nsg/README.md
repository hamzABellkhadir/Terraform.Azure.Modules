<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.78.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.78.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.custom_network_security_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_subnet_network_security_group_association.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_associated_subnet_id"></a> [associated\_subnet\_id](#input\_associated\_subnet\_id) | (Optional) List of subnets to be associated with the Network Security Group. | `list(any)` | `[]` | no |
| <a name="input_custom_security_rules"></a> [custom\_security\_rules](#input\_custom\_security\_rules) | A list of security rules to add to the security group. Each rule should be a map of values to add. | <pre>list(object({<br>    priority                                   = number<br>    name                                       = string<br>    direction                                  = optional(string, "Inbound")<br>    access                                     = optional(string, "Allow")<br>    protocol                                   = optional(string, "Tcp")<br>    source_port_range                          = optional(string)<br>    source_port_ranges                         = optional(list(string))<br>    destination_port_range                     = optional(string)<br>    destination_port_ranges                    = optional(list(string))<br>    source_address_prefix                      = optional(string)<br>    source_address_prefixes                    = optional(list(string))<br>    destination_address_prefix                 = optional(string)<br>    destination_address_prefixes               = optional(list(string))<br>    source_application_security_group_ids      = optional(list(string))<br>    destination_application_security_group_ids = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The Azure region where the Network Security Group will be deployed. | `string` | `"westeurope"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Network Security Group. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The Azure Resource Group for the Network Security Group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) Tags associated with the created resources. | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nsg_id"></a> [nsg\_id](#output\_nsg\_id) | The unique identifier of the newly created Network Security Group. |

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

module "nsg" {
  source              = "../"
  name                = "we-nsg-webapp-0001"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = {
    description = "nsg web app"
  }
  associated_subnet_id = []

  custom_security_rules = [
    {
      name                       = "AllowSSH"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowHTTP"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

# EOF
```
<!-- END_TF_DOCS -->