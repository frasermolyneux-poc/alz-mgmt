variable "alz_workload_settings" {
  type        = any
  default     = {}
  description = <<DESCRIPTION
The shared settings for the alz workloads. This is where global resources are defined.
DESCRIPTION
}
