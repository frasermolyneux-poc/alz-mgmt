output "hub_and_spoke_vnet_virtual_networks" {
  value = local.hub_and_spoke_vnet_virtual_networks
}

output "hub_and_spoke_output" {
  value = module.hub_and_spoke_vnet
}

output "private_dns_zone_ids" {
  value = module.hub_and_spoke_vnet[0].private_dns_zone_ids
}

output "private_dns_zones_local" {
  value = module.workloads.private_dns_zones_local
}

output "vnet_outputs" {
  value = module.workloads.vnet_outputs
}
