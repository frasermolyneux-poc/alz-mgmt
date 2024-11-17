locals {
  location                      = var.alz_workload_settings.location
  resource_group_name           = var.alz_workload_settings.resource_group_name
  virtual_network_name          = var.alz_workload_settings.virtual_network_settings.virtual_network_name
  virtual_network_address_space = var.alz_workload_settings.virtual_network_settings.virtual_network_address_space
  virtual_network_subnets       = var.alz_workload_settings.virtual_network_settings.virtual_network_subnets
  virtual_network_peerings      = var.alz_workload_settings.virtual_network_settings.virtual_network_peerings

  private_dns_zones = { for key, value in var.hub_virtual_networks : key => merge({
    location = value.hub_virtual_network.location
  }, value.private_dns_zones) if can(value.private_dns_zones.resource_group_name) }
}
