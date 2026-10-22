output "service_name" {
  description = "Private Kubernetes service name."
  value       = kubernetes_service_v1.app.metadata[0].name
}

output "namespace" {
  description = "Kubernetes namespace hosting the application."
  value       = kubernetes_namespace_v1.app.metadata[0].name
}

output "port_forward_command" {
  description = "Command to access the private service from the local workstation."
  value       = "kubectl -n ${kubernetes_namespace_v1.app.metadata[0].name} port-forward service/${kubernetes_service_v1.app.metadata[0].name} 8080:80"
}
