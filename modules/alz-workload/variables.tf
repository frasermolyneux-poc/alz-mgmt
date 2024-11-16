variable "alz_workload_settings" {
  type = optional(object({
    location   = string
    github_org = string
    virtual_network_settings = object({
      virtual_network_address_space = string
      subnets                       = any
    })
  }))
  default     = {}
  description = <<DESCRIPTION
The shared settings for the alz workloads. This is where global resources are defined.
DESCRIPTION
}
