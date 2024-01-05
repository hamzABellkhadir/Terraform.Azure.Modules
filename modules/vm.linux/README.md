<!-- BEGIN_TF_DOCS -->


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.78.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.78.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_install_apache2"></a> [install\_apache2](#module\_install\_apache2) | ./modules/ansible | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_application_security_group_association.asg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_application_security_group_association) | resource |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [random_password.pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Optional) The name of the administrator user. | `string` | `"adminuser"` | no |
| <a name="input_asg_enabled"></a> [asg\_enabled](#input\_asg\_enabled) | (Optional) Enable Application Security Group association (asg\_id required). | `bool` | `false` | no |
| <a name="input_asg_id"></a> [asg\_id](#input\_asg\_id) | (Optional) Application Security Group ID to be associated with the virtual machine. | `string` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional) DNS servers to be applied to the VM. | `list(string)` | `[]` | no |
| <a name="input_enable_ultra_ssd"></a> [enable\_ultra\_ssd](#input\_enable\_ultra\_ssd) | (Optional) Enables or disables ultra SSD. | `bool` | `false` | no |
| <a name="input_is_apache2_config_enabled"></a> [is\_apache2\_config\_enabled](#input\_is\_apache2\_config\_enabled) | (Optional) Flag to activate the Ansible configuration for the virtual machine. | `bool` | `true` | no |
| <a name="input_is_dynamic_ip_enabled"></a> [is\_dynamic\_ip\_enabled](#input\_is\_dynamic\_ip\_enabled) | (Optional) Automatically assigns an IP during the creation of this Network Interface. | `bool` | `true` | no |
| <a name="input_is_public_ip_enabled"></a> [is\_public\_ip\_enabled](#input\_is\_public\_ip\_enabled) | (Optional) Assigns a public IP during the creation of this Network Interface. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The Azure region name. Defaults to the virtual machine resource group location if not provided. | `string` | `""` | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | (Optional) The size and type of the OS disk. | `map(string)` | <pre>{<br>  "size": 64,<br>  "type": "Premium_LRS"<br>}</pre> | no |
| <a name="input_private_ip_address"></a> [private\_ip\_address](#input\_private\_ip\_address) | (Required if is\_dynamic\_ip\_enabled set to false) Reference to a Public IP Address to associate with this NIC. | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group for the virtual machine. | `string` | n/a | yes |
| <a name="input_static_web_path"></a> [static\_web\_path](#input\_static\_web\_path) | (Optional) The path of the web page to be deployed. | `string` | `"index.html"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | (Required) The name of the subnet. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) Tags associated with the resources. | `map(string)` | <pre>{<br>  "description": "Terraform code"<br>}</pre> | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | (Required) The name of the virtual machine. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Optional) The size of the virtual machine. | `string` | `"Standard_B2ms"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | (Required) The name of the virtual network where the subnet is located. | `string` | n/a | yes |
| <a name="input_vnet_rg_name"></a> [vnet\_rg\_name](#input\_vnet\_rg\_name) | (Required) The name of the resource group where the virtual network is located. | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | (Optional) The availability zone of the virtual machine. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_account"></a> [admin\_account](#output\_admin\_account) | The admin username for the virtual machine. |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | Auto-generated admin password for the virtual machine. |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | The id of the Network Interface associated with the virtual machine. |
| <a name="output_network_interface_ip"></a> [network\_interface\_ip](#output\_network\_interface\_ip) | The private IP address of the Network Interface. |
| <a name="output_vm_id"></a> [vm\_id](#output\_vm\_id) | The unique identifier of the virtual machine. |

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

module "vmlinux" {
  source              = "../"
  vm_name             = "vmlinux0001"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_rg_name        = "resource group name of the vnet"
  vnet_name           = "vnet name"
  subnet_name         = "subnet-name"
  asg_enabled         = true
  asg_id              = "asg id"
}

# EOF
```
<!-- END_TF_DOCS -->