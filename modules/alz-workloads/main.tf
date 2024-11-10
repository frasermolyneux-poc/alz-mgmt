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
