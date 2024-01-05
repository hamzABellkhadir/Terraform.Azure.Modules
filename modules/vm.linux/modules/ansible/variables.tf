###
# Variables
###

variable "ansible_vm_ip" {
  type        = string
  description = "(Required) The IP address of the Ansible-managed VM."
}

variable "admin_agent_password" {
  type        = string
  default     = ""
  description = "(Optional) The default configuration agent password."
}

variable "admin_agent_username" {
  type        = string
  default     = "adminuser"
  description = "(Optional) The default configuration agent username."
}

variable "static_web_path" {
  type        = string
  default     = "index.html"
  description = "(Optional) The path of the web page to be deployed."
}

# EOF
