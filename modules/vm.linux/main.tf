###
# Terraform
###

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.78.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }
  }
  required_version = ">= 1.5"
}


###
# Locales
###

locals {
  base_image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

}


###
# Resources
####

resource "random_password" "pass" {
  length           = 16
  special          = true
  numeric          = true
  upper            = true
  lower            = true
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
  override_special = "_-+=/"
}

#### Network ####

###
# Data
####

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.vnet_rg_name
}


###
# Resources
####


resource "azurerm_public_ip" "public_ip" {
  for_each            = toset(is_public_ip_enabled ? ["enabled"] : [])
  name                = "publicip-${var.vm_name}"
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"
}


resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.vm_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_servers         = var.dns_servers
  tags                = var.tags

  ip_configuration {
    name                          = "nic-config-${var.vm_name}"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = var.is_dynamic_ip_enabled ? "Dynamic" : "Static"
    private_ip_address            = var.is_dynamic_ip_enabled ? null : var.private_ip_address
    public_ip_address_id          = is_public_ip_enabled ? azurerm_public_ip.public_ip["enabled"].id : null
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

#### ASG Associations ####

###
# Resources
####

resource "azurerm_network_interface_application_security_group_association" "asg" {
  count                         = var.asg_enabled ? 1 : 0
  network_interface_id          = azurerm_network_interface.nic.id
  application_security_group_id = var.asg_id
}




resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vm_size
  zone                  = var.enable_ultra_ssd == true ? "1" : null

  disable_password_authentication = false
  provision_vm_agent              = true
  allow_extension_operations      = true
  tags                            = var.tags
  admin_username                  = var.admin_username
  admin_password                  = random_password.pass.result


  os_disk {
    name                 = "${var.vm_name}-osDisk"
    caching              = "ReadWrite"
    disk_size_gb         = var.os_disk.size
    storage_account_type = var.os_disk.type
  }

  source_image_reference {
    publisher = local.base_image.publisher
    offer     = local.base_image.offer
    sku       = local.base_image.sku
    version   = local.base_image.version
  }

  boot_diagnostics {
    storage_account_uri = ""
  }

  lifecycle {
    ignore_changes = [
      source_image_reference,
      tags,
      identity
    ]
  }

}

# EOF



#### installation of apache2 ####
module "install_apache2" {
  count                = var.is_apache2_config_enabled == true ? 1 : 0
  source               = "./modules/ansible"
  static_web_path      = var.static_web_path
  ansible_vm_ip        = zurerm_network_interface.nic.private_ip_address
  admin_agent_password = random_password.pass.result
  admin_agent_username = var.admin_username
  depends_on           = [azurerm_linux_virtual_machine.vm]
}

# EOF
