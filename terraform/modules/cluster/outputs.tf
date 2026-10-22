output "cluster_name" {
  description = "Name of the Google Kubernetes Engine cluster."
  value       = google_container_cluster.sandbox.name
}

output "cluster_location" {
  description = "Zone or region hosting the Google Kubernetes Engine cluster."
  value       = google_container_cluster.sandbox.location
}

output "node_service_account" {
  description = "Service account used by cluster worker nodes to pull images."
  value       = "${data.google_project.current.number}-compute@developer.gserviceaccount.com"
}
