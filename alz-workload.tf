module "workloads" {
  source = "./modules/alz-workload"

  alz_workload_settings               = var.alz_workload_settings
  private_dns_zones_resource_group_id = module.hub_and_spoke_vnet[0].private_dns_zones_resource_group_id

  providers = {
    github = github
  }
}
