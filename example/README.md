<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                      | Version |
|---------------------------------------------------------------------------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.41.0 | 

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.41.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nsg"></a> [nsg](#module\_nsg) | git::https://github.com/hamzABellkhadir/Terraform.Azure.Modules.git//modules/nsg | n/a |
| <a name="module_vmlinux"></a> [vmlinux](#module\_vmlinux) | git::https://github.com/hamzABellkhadir/Terraform.Azure.Modules.git//modules/vm.linux | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | git::https://github.com/hamzABellkhadir/Terraform.Azure.Modules.git//modules/vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azuread_group.admin_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group.dev_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group.po_group](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azurerm_application_security_group.asg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_security_group) | resource |
| [azurerm_role_assignment.admin_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.dev_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.po_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.admin_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.dev_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_role_definition.po_role](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | (Optional) The name of the Application Security Group | `string` | `"asg-web-app"` | no |
| <a name="input_assignable_scopes"></a> [assignable\_scopes](#input\_assignable\_scopes) | (Optional) List of assignable scopes for role assignment | `list(string)` | <pre>[<br>  "/subscriptions/965ab6d3-fa18-45bd-b2c2-c813de59b590"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | (Optional) The Azure region location | `string` | `"westeurope"` | no |
| <a name="input_nsg_name"></a> [nsg\_name](#input\_nsg\_name) | (Optional) The name of the Network Security Group | `string` | `"we-nsg-webapp-0001"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Optional) The name of the Azure resource group | `string` | `"Regroup_1lH8p61y0FfW603O"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | (Required) The Azure subscription ID | `string` | `"965ab6d3-fa18-45bd-b2c2-c813de59b590"` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | (Required) The Azure AD tenant ID | `string` | `"9b7cbd77-6d6b-4879-8aba-63d7dfb18472"` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | (Optional) The name of the Virtual Machine | `string` | `"vmlinux0001"` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | (Optional) The name of the Virtual Network | `string` | `"we-vnet-webapp-0001"` | no |



<!-- END_TF_DOCS -->