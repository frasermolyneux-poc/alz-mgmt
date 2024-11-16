locals {
  location                      = var.alz_workload_settings.location
  virtual_network_address_space = var.alz_workload_settings.virtual_network_settings.virtual_network_address_space
  virtual_network_subnets       = var.alz_workload_settings.virtual_network_settings.virtual_network_subnets
}
