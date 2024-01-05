###
# Terraform
###

terraform {
  required_providers {
    template = {
      source = "hashicorp/template"
      version = ">= 2.2.0"
    }
    local = {
      source = "hashicorp/local"
      version = ">= 2.4.1"
    }
    null = {
      source = "hashicorp/null"
      version = ">= 3.2.2"
    }
  }
  required_version = ">= 1.5"
}

data "template_file" "host_ini" {
  template = file("${path.module}/host.ini.tpl")
  vars = {
    ip       = var.ansible_vm_ip
    user     = var.admin_agent_username
    password = var.admin_agent_password
  }
}

data "template_file" "script_ansible_ini" {
  template = file("${path.module}/playbook.sh.tpl")
  vars = {
    static_web_path = var.static_web_path
  }
}


resource "local_file" "script_ansible_ini" {
  content  = data.template_file.script_ansible_ini.rendered
  filename = "${path.module}/playbook/playbook.sh"
}

resource "local_file" "host_ini" {
  content  = data.template_file.host_ini.rendered
  filename = "${path.module}/playbook/host.ini"
}


resource "null_resource" "execute_playbook" {
  provisioner "local-exec" {
    command     = "cd ${path.module}/playbook && chmod +x playbook.sh && ./playbook.sh"
    interpreter = ["bash", "-c"]
  }
  depends_on = [local_file.host_ini , local_file.script_ansible_ini]
}