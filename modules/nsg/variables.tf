###
# Variables
###

variable "resource_group_name" {
  type        = string
  description = "(Required) The Azure Resource Group for the Network Security Group."
}

variable "name" {
  type        = string
  description = "(Required) The name of the Network Security Group."
}

variable "location" {
  type        = string
  default     = "westeurope"
  description = "(Optional) The Azure region where the Network Security Group will be deployed."
}


variable "tags" {
  type        = map(string)
  description = "(Required) Tags associated with the created resources."
}

variable "associated_subnet_id" {
  type        = list(any)
  default     = []
  description = "(Optional) List of subnets to be associated with the Network Security Group."
}

variable "custom_security_rules" {
  type = list(object({
    priority                                   = number
    name                                       = string
    direction                                  = optional(string, "Inbound")
    access                                     = optional(string, "Allow")
    protocol                                   = optional(string, "Tcp")
    source_port_range                          = optional(string)
    source_port_ranges                         = optional(list(string))
    destination_port_range                     = optional(string)
    destination_port_ranges                    = optional(list(string))
    source_address_prefix                      = optional(string)
    source_address_prefixes                    = optional(list(string))
    destination_address_prefix                 = optional(string)
    destination_address_prefixes               = optional(list(string))
    source_application_security_group_ids      = optional(list(string))
    destination_application_security_group_ids = optional(list(string))
  }))
  default     = []
  description = "A list of security rules to add to the security group. Each rule should be a map of values to add."
}

# EOF
