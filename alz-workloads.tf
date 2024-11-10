module "workloads" {
  source = "./modules/alz-workloads"

  providers = {
    github = github
  }
}
