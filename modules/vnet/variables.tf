###
# Variables
###

variable "name" {
  type        = string
  description = "(Required) The name of the Azure Virtual Network."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Azure Resource Group."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "(Optional) The Azure region in which resources will be deployed."
}

variable "dns_servers" {
  type        = set(string)
  default     = []
  description = "(Optional) List of DNS servers used for the Virtual Network."
}

variable "address_space" {
  type        = set(string)
  description = "(Required) IP Address space used for this Virtual Network."
}

variable "subnets" {
  type = list(object({
    address_range                             = set(string)
    service_endpoints                         = optional(set(string))
    name                                      = string
    private_endpoint_network_policies_enabled = bool
    service_delegation = optional(map(object({
      name   = string
      action = set(string)
    })))
  }))
  default     = []
  description = "(Optional) List of Subnets to be attached to this Virtual Network."
}

# EOF
