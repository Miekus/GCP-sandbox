output "cluster_name" {
  description = "Name of the Google Kubernetes Engine cluster."
  value       = module.cluster.cluster_name
}

output "cluster_location" {
  description = "Zone or region hosting the Google Kubernetes Engine cluster."
  value       = module.cluster.cluster_location
}

output "cloud_router_asn" {
  description = "Private Border Gateway Protocol autonomous system number configured on the Cloud Router."
  value       = module.network.cloud_router_asn
}

output "vpn_gateway_public_ips" {
  description = "Public IP addresses assigned to the high-availability Cloud VPN gateway."
  value       = module.vpn.gateway_public_ips
}
