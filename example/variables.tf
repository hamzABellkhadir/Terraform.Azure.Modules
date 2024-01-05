
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

