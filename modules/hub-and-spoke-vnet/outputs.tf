output "private_dns_zones_output" {
  value = module.private_dns_zones
}

output "private_dns_zone_ids" {
  value = module.private_dns_zones.primary.private_dns_zone_resource_ids
}
