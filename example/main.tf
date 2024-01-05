# Define required Terraform version and providers
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.41.0"
    }
  }
  required_version = ">= 1.5"
}

# Configure Azure provider
provider "azurerm" {
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  skip_provider_registration = true
  features {}
}

# Create an Azure Application Security Group
resource "azurerm_application_security_group" "asg" {
  name                = var.asg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    description = "asg attached to the web server"
  }
}

# Use a Terraform module to create a virtual network
module "vnet" {
  source              = "git::https://github.com/hamzABellkhadir/Terraform.Azure.Modules.git//modules/vnet"
  name                = var.vnet_name
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

# Use a Terraform module to create a network security group (NSG)
module "nsg" {
  source              = "git::https://github.com/hamzABellkhadir/Terraform.Azure.Modules.git//modules/nsg"
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = {
    description = "nsg web app"
  }
  associated_subnet_id = module.vnet.subnets_id

  custom_security_rules = [
    {
      name                                       = "AllowSSH"
      priority                                   = 1001
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "22"
      source_address_prefix                      = "*"
      destination_application_security_group_ids = [azurerm_application_security_group.asg.id]
    },
    {
      name                                       = "AllowHTTP"
      priority                                   = 1002
      direction                                  = "Inbound"
      access                                     = "Allow"
      protocol                                   = "Tcp"
      source_port_range                          = "*"
      destination_port_range                     = "80"
      source_address_prefix                      = "*"
      destination_application_security_group_ids = [azurerm_application_security_group.asg.id]
    }
  ]
  depends_on = [module.vnet]
}

# Use a Terraform module to create a Linux virtual machine
module "vmlinux" {
  source              = "git::https://github.com/hamzABellkhadir/Terraform.Azure.Modules.git//modules/vm.linux"
  vm_name             = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_rg_name        = var.resource_group_name
  vnet_name           = module.vnet.vnet_name
  subnet_name         = module.vnet.subnets_name[0]
  asg_enabled         = true
  asg_id              = azurerm_application_security_group.asg.id

  static_web_path = "${abspath(path.module)}/index.html"
  depends_on      = [module.vnet]
}
