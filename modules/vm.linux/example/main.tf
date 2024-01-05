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