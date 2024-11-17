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

// Pulled from hub and spoke module
variable "hub_virtual_networks" {
  type = map(object({
    hub_virtual_network = any
    virtual_network_gateways = optional(object({
      express_route = optional(any)
      vpn           = optional(any)
    }))
    private_dns_zones = optional(object({
      resource_group_name = string
      is_primary          = optional(bool, false)
    }))
  }))
  default     = {}
  description = <<DESCRIPTION
A map of hub networks to create. 

The following attributes are supported:

  - hub_virtual_network: The hub virtual network settings. Detailed information about the hub virtual network can be found in the module's README: https://registry.terraform.io/modules/Azure/avm-ptn-hubnetworking
  - virtual_network_gateways: (Optional) The virtual network gateway settings. Detailed information about the virtual network gateway can be found in the module's README: https://registry.terraform.io/modules/Azure/avm-ptn-vnetgateway
  - private_dns_zones: (Optional) The private DNS zone settings. Detailed information about the private DNS zone can be found in the module's README: https://registry.terraform.io/modules/Azure/avm-ptn-network-private-link-private-dns-zones

DESCRIPTION
}

variable "combined_private_link_private_dns_zones_replaced_with_vnets_to_link_to" {
  type        = any
  default     = {}
  description = "The combined private link private DNS zones replaced with the virtual networks to link to."
}
