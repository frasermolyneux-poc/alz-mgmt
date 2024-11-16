output "private_dns_zone_ids" {
  value = module.private_dns_zones.combined_private_link_private_dns_zones_replaced_with_vnets_to_link
}
