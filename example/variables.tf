variable "tenant_id" {
  description = "(Required) The Azure AD tenant ID"
  type        = string
  default     = "9b7cbd77-6d6b-4879-8aba-63d7dfb18472"
}

variable "subscription_id" {
  description = "(Required) The Azure subscription ID"
  type        = string
  default     = "965ab6d3-fa18-45bd-b2c2-c813de59b590"
}

variable "resource_group_name" {
  description = "(Optional) The name of the Azure resource group"
  type        = string
  default     = "Regroup_1lH8p61y0FfW603O"
}

variable "location" {
  description = "(Optional) The Azure region location"
  type        = string
  default     = "westeurope"
}

variable "nsg_name" {
  description = "(Optional) The name of the Network Security Group"
  type        = string
  default     = "we-nsg-webapp-0001"
}

variable "asg_name" {
  description = "(Optional) The name of the Application Security Group"
  type        = string
  default     = "asg-web-app"
}

variable "vnet_name" {
  description = "(Optional) The name of the Virtual Network"
  type        = string
  default     = "we-vnet-webapp-0001"
}

variable "vm_name" {
  description = "(Optional) The name of the Virtual Machine"
  type        = string
  default     = "vmlinux0001"
}

variable "assignable_scopes" {
  description = "(Optional) List of assignable scopes for role assignment"
  type        = list(string)
  default     = ["/subscriptions/965ab6d3-fa18-45bd-b2c2-c813de59b590"]
}
