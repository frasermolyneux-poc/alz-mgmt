resource "azurerm_resource_group" "rg_github_kv" {
  name     = "rg-alz-workloads-${local.location}"
  location = local.location
}

resource "random_id" "kv_id" {
  byte_length = 4
}

resource "azurerm_key_vault" "github_kv" {
  name                = "kv-${random_id.kv_id.hex}-${local.location}"
  location            = azurerm_resource_group.rg_github_kv.location
  resource_group_name = azurerm_resource_group.rg_github_kv.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  soft_delete_retention_days = 90
  purge_protection_enabled   = true
  enable_rbac_authorization  = true

  sku_name = "standard"

  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
  }
}

resource "azurerm_role_assignment" "deploy_principal_kv_role_assignment" {
  scope                = azurerm_key_vault.github_kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "github_runners_access_token" {
  name         = "github-runners-access-token"
  value        = "placeholder"
  key_vault_id = azurerm_key_vault.github_kv.id

  lifecycle {
    ignore_changes = [value]
  }
}

resource "github_repository" "alz" {
  name        = "alz-workloads"
  description = "alz-workloads"

  auto_init = true

  visibility = "public"

  allow_update_branch  = true
  allow_merge_commit   = false
  allow_rebase_merge   = false
  vulnerability_alerts = true
}

//module "avm-ptn-cicd-agents-and-runners_example_github_container_instance" {
//  source  = "Azure/avm-ptn-cicd-agents-and-runners/azurerm//examples/github_container_instance"
//  version = "0.1.4"
//
//  compute_types                                = ["azure_container_instance"]
//  postfix                                      = random_string.name.result
//  location                                     = local.selected_region
//  version_control_system_type                  = "github"
//  version_control_system_personal_access_token = var.github_runners_personal_access_token
//  version_control_system_organization          = var.github_organization_name
//  version_control_system_repository            = github_repository.this.name
//  virtual_network_address_space                = "10.0.0.0/16"
//  tags                                         = local.tags
//  depends_on                                   = [github_repository_file.this]
//}
