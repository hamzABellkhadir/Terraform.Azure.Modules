# Create IAM roles and policies

# Admin role definition
resource "azurerm_role_definition" "admin_role" {
  name        = "AdminRole"
  scope       = var.assignable_scopes[0]  # Set the scope for the role assignment
  description = "Administrator access to all Azure resources."
  permissions {
    actions     = ["*"]  # Allow all actions
    not_actions = []     # No actions are explicitly denied
  }
  assignable_scopes = var.assignable_scopes  # Assignable scopes for the role
}

# Dev role definition
resource "azurerm_role_definition" "dev_role" {
  name        = "DevRole"
  scope       = var.assignable_scopes[0]  # Set the scope for the role assignment
  description = "Limited editor access to VMs."
  permissions {
    actions     = ["Microsoft.Compute/virtualMachines/write"]  # Allow write actions for VMs
    not_actions = []  # No actions are explicitly denied
  }
  assignable_scopes = var.assignable_scopes  # Assignable scopes for the role
}

# PO role definition
resource "azurerm_role_definition" "po_role" {
  name        = "PORole"
  scope       = var.assignable_scopes[0]  # Set the scope for the role assignment
  description = "Reader access to VMs."
  permissions {
    actions     = ["Microsoft.Compute/virtualMachines/read"]  # Allow read actions for VMs
    not_actions = []  # No actions are explicitly denied
  }
  assignable_scopes = var.assignable_scopes  # Assignable scopes for the role
}

# Create IAM groups

# Admin group
resource "azuread_group" "admin_group" {
  display_name    = "AdminGroup"
  description     = "IAM Admin Group"
  security_enabled = true  # Security-enabled group
}

# Dev group
resource "azuread_group" "dev_group" {
  display_name    = "DevGroup"
  description     = "IAM Dev Group"
  security_enabled = true  # Security-enabled group
}

# PO group
resource "azuread_group" "po_group" {
  display_name    = "POGroup"
  description     = "IAM PO Group"
  security_enabled = true  # Security-enabled group
}

# Assign roles to groups

# Admin role assignment
resource "azurerm_role_assignment" "admin_assignment" {
  principal_id         = azuread_group.admin_group.id  # Assign to the Admin group
  role_definition_name = azurerm_role_definition.admin_role.name  # Use the Admin role definition
  scope                = azurerm_role_definition.admin_role.assignable_scopes[0]  # Set the scope for the role assignment
}

# Dev role assignment
resource "azurerm_role_assignment" "dev_assignment" {
  principal_id         = azuread_group.dev_group.id  # Assign to the Dev group
  role_definition_name = azurerm_role_definition.dev_role.name  # Use the Dev role definition
  scope                = azurerm_role_definition.dev_role.assignable_scopes[0]  # Set the scope for the role assignment
}

# PO role assignment
resource "azurerm_role_assignment" "po_assignment" {
  principal_id         = azuread_group.po_group.id  # Assign to the PO group
  role_definition_name = azurerm_role_definition.po_role.name  # Use the PO role definition
  scope                = azurerm_role_definition.po_role.assignable_scopes[0]  # Set the scope for the role assignment
}
