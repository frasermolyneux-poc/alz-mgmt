module "workloads" {
  source = "./modules/alz-workload"

  alz_workload_settings = var.alz_workload_settings
  private_dns_zone_ids  = module.hub_and_spoke_vnet[0].private_dns_zone_ids

  enable_telemetry = var.enable_telemetry

  providers = {
    github = github
  }
}
