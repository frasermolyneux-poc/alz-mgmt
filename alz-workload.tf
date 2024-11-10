module "workloads" {
  source = "./modules/alz-workload"

  alz_workload_settings = var.alz_workload_settings

  providers = {
    github = github
  }
}
