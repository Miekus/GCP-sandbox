resource "google_project_service" "artifact_registry" {
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "app" {
  project       = var.project_id
  location      = var.region
  repository_id = var.repository_name
  description   = "Container images for the GCP sandbox application"
  format        = "DOCKER"

  depends_on = [google_project_service.artifact_registry]
}
