<!-- BEGIN_TF_DOCS -->


## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.

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

resource "azurerm_application_security_group" "asg" {
  name                = "asg-web-app"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    description = "asg attached to the web server"
  }
}

module "vnet" {
  source              = "../modules/vnet"
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

module "nsg" {
  source              = "../modules/nsg"
  name                = "we-nsg-webapp-0001"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = {
    description = "nsg web app"
  }
  associated_subnet_id = module.vnet.subnets_id

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
  depends_on = [module.vnet]
}


module "vmlinux" {
  source              = "../modules/vm.linux"
  vm_name             = "vmlinux0001"
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_rg_name        = var.resource_group_name
  vnet_name           = module.vnet.vnet_name
  subnet_name         = module.vnet.subnets_name[0]
  asg_enabled         = true
  asg_id              = azurerm_application_security_group.asg.id

  depends_on = [module.vnet]
}


# EOF
```
<!-- END_TF_DOCS -->