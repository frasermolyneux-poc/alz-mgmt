output "private_dns_zones_local" {
  value = local.private_dns_zones
}

output "vnet_outputs" {
  value = module.virtual_network
}
