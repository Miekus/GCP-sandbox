output "network_id" {
  description = "ID of the virtual private cloud network."
  value       = google_compute_network.sandbox.id
}

output "subnetwork_id" {
  description = "ID of the cluster subnet."
  value       = google_compute_subnetwork.sandbox.id
}

output "pod_range_name" {
  description = "Name of the subnet secondary range for cluster pods."
  value       = "pods"
}

output "service_range_name" {
  description = "Name of the subnet secondary range for cluster services."
  value       = "services"
}

output "cloud_router_asn" {
  description = "Private Border Gateway Protocol autonomous system number configured on the Cloud Router."
  value       = google_compute_router.sandbox.bgp[0].asn
}
