variable "alz_workload_settings" {
  type = object({
    location            = optional(string)
    github_org          = optional(string)
    resource_group_name = optional(string),
    virtual_network_settings = optional(object({
      virtual_network_name          = optional(string)
      virtual_network_address_space = optional(string)
      virtual_network_subnets       = optional(any)
      virtual_network_peerings      = optional(any)
    }))
  })
  default     = {}
  description = <<DESCRIPTION
The shared settings for the alz workloads. This is where global resources are defined.
DESCRIPTION
}
