output "hub_and_spoke_vnet_virtual_networks" {
  value = local.hub_and_spoke_vnet_virtual_networks
}

output "private_dns_zone_ids" {
  value = module.hub_and_spoke_vnet.private_dns_zone_ids
}
