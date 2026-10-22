output "docker_repository_url" {
  description = "Docker repository URL for application images."
  value       = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.app.repository_id}"
}
