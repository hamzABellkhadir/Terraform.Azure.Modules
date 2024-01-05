terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.41.0"
    }
  }
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