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

variable "private_dns_zone_ids" {
  type        = map(string)
  default     = {}
  description = "The private DNS zone IDs."
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}
