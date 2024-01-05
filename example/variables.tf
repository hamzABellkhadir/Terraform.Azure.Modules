
variable "tenant_id" {
  description = "(Required) tenant id"
  type        = string
  default     = "9b7cbd77-6d6b-4879-8aba-63d7dfb18472"
}
variable "subscription_id" {
  description = "(Required) subscription ID"
  type        = string
  default     = "965ab6d3-fa18-45bd-b2c2-c813de59b590"
}
variable "resource_group_name" {
  type    = string
  default = "Regroup_1lH8p61y0FfW603O"
}

variable "location" {
  type    = string
  default = "westeurope"
}

