output "gateway_public_ips" {
  description = "Public IP addresses assigned to the high-availability Cloud VPN gateway."
  value       = [for vpn_interface in google_compute_ha_vpn_gateway.sandbox.vpn_interfaces : vpn_interface.ip_address]
}
