module "workloads" {
  source = "./modules/alz-workload"

  alz_workload_settings = var.alz_workload_settings
  //private_dns_zones_resource_group_name = var.hub_virtual_networks.hub_and_spoke_vnet_virtual_networks.primary.private_dns_zones.resource_group_name

  providers = {
    github = github
  }
}
