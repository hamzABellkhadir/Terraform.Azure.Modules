###
# Variables
###

variable "vm_name" {
  type        = string
  description = "(Required) The name of the virtual machine."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group for the virtual machine."
}

variable "location" {
  type        = string
  description = "(Optional) The Azure region name. Defaults to the virtual machine resource group location if not provided."
  default     = ""
}

variable "admin_username" {
  type        = string
  default     = "adminuser"
  description = "(Optional) The name of the administrator user."
}

variable "tags" {
  type        = map(string)
  description = "(Required) Tags associated with the resources."
  default = {
    description = "Terraform code"
  }
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "(Optional) DNS servers to be applied to the VM."
}

variable "vm_size" {
  type        = string
  default     = "Standard_B2ms"
  description = "(Optional) The size of the virtual machine."
}

variable "zone" {
  type        = string
  default     = null
  description = "(Optional) The availability zone of the virtual machine."
}

variable "os_disk" {
  type = map(string)
  default = {
    type = "Premium_LRS"
    size = 64
  }
  description = "(Optional) The size and type of the OS disk."
}

############################# Network variables ######################################
variable "vnet_rg_name" {
  type        = string
  description = "(Required) The name of the resource group where the virtual network is located."
}

variable "vnet_name" {
  type        = string
  description = "(Required) The name of the virtual network where the subnet is located."
}

variable "subnet_name" {
  type        = string
  description = "(Required) The name of the subnet."
}

variable "asg_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enable Application Security Group association (asg_id required)."
}

variable "asg_id" {
  type        = string
  default     = null
  description = "(Optional) Application Security Group ID to be associated with the virtual machine."
}

variable "enable_ultra_ssd" {
  type        = bool
  default     = false
  description = "(Optional) Enables or disables ultra SSD."
}

################################ Static IP #################################
variable "is_dynamic_ip_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Automatically assigns an IP during the creation of this Network Interface."
}

variable "private_ip_address" {
  type        = string
  default     = ""
  description = "(Required if is_dynamic_ip_enabled set to false) Reference to a Public IP Address to associate with this NIC."
}

variable "is_public_ip_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Assigns a public IP during the creation of this Network Interface."
}

################################ ANSIBLE Variables ################################
variable "is_apache2_config_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Flag to activate the Ansible configuration for the virtual machine."
}

variable "static_web_path" {
  type        = string
  default     = "index.html"
  description = "(Optional) The path of the web page to be deployed."
}

# EOF
