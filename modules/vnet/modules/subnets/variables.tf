###
# Variables
###

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Azure Resource Group."
}
variable "name" {
  type        = string
  description = "(Required) The name of subnet."
}
variable "route_table_id" {
  type        = string
  description = "(Required) The ID of the route table."
}

variable "vnet_name" {
  type        = string
  description = "(Required) The name of the Azure Virtual Network."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "(Optional) The Azure region where the resources will be provisioned."
}

variable "address_range" {
  type        = set(string)
  description = "(Required) The address range(s) for the virtual network."
}

variable "service_endpoints" {
  type        = set(string)
  default     = []
  description = "(Optional) The list of service endpoints to configure for the virtual network."
}

variable "service_delegation" {
  type = map(object({
    name   = string
    action = set(string)
  }))
  default     = {}
  description = "(Optional) The service delegation configurations for the virtual network."
}

variable "private_endpoint_network_policies_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Controls whether network policies are enabled for private endpoints."
}

# EOF
