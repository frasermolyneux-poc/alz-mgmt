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

module "resource_group" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.1.0"

  location = local.location
  name     = local.resource_group_name

  enable_telemetry = var.enable_telemetry
  tags             = var.tags
}

data "azurerm_virtual_network" "peers" {
  for_each = local.virtual_network_peerings

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

locals {
  virtual_network_peerings_linked_to_data_resource = {
    for virtual_network_peering_key, virtual_network_peering in local.virtual_network_peerings : virtual_network_peering_key => {
      name                               = virtual_network_peering.name
      remote_virtual_network_resource_id = data.azurerm_virtual_network.peers[virtual_network_peering_key].id
    }
  }

}

module "virtual_network" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.6.0"

  name = local.virtual_network_name

  resource_group_name = module.resource_group.resource.name
  location            = module.resource_group.resource.location

  address_space = [local.virtual_network_address_space]

  subnets = local.virtual_network_subnets

  peerings = local.virtual_network_peerings_linked_to_data_resource

  enable_telemetry = var.enable_telemetry
  tags             = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.combined_private_link_private_dns_zones_replaced_with_vnets_to_link_to

  name                  = "vnet_link-${each.value.zone_key}-${local.virtual_network_name}"
  private_dns_zone_name = each.value.zone_value.zone_name
  resource_group_name   = local.private_dns_zones.primary.resource_group_name
  virtual_network_id    = module.virtual_network.resource.id
  registration_enabled  = false

  tags = var.tags
}

data "azurerm_client_config" "this" {}

resource "random_id" "kv_id" {
  byte_length = 4
}

module "key_vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.9.1"

  name             = "kv-${random_id.kv_id.hex}-${local.location}"
  enable_telemetry = var.enable_telemetry

  location            = module.resource_group.resource.location
  resource_group_name = module.resource_group.resource.name

  tenant_id = data.azurerm_client_config.this.tenant_id

  public_network_access_enabled = false

  private_endpoints = {
    primary = {
      private_dns_zone_resource_ids = [var.private_dns_zone_ids.azure_key_vault]
      subnet_resource_id            = module.virtual_network.subnets.endpoints.resource.id
    }
  }
}

resource "azurerm_role_assignment" "deploy_principal_kv_role_assignment" {
  scope                = module.key_vault.resource.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.this.object_id
}

resource "azurerm_key_vault_secret" "github_runners_access_token" {
  name         = "github-runners-access-token"
  value        = "placeholder"
  key_vault_id = module.key_vault.resource.id

  lifecycle {
    ignore_changes = [value]
  }

  depends_on = [azurerm_role_assignment.deploy_principal_kv_role_assignment]
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
