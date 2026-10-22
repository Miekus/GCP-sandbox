variable "project_id" {
  description = "Google Cloud project containing the target cluster."
  type        = string
}

variable "region" {
  description = "Google Cloud region used for the provider."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Name of the existing Google Kubernetes Engine cluster."
  type        = string
  default     = "sandbox-gke"
}

variable "cluster_location" {
  description = "Zone or region of the existing Google Kubernetes Engine cluster."
  type        = string
  default     = "us-central1-a"
}

variable "image" {
  description = "Full Artifact Registry image path, including tag."
  type        = string

  validation {
    condition     = length(trimspace(var.image)) > 0 && !strcontains(var.image, "PROJECT_ID")
    error_message = "image must be a complete container image path and must not contain the PROJECT_ID placeholder."
  }
}

variable "replicas" {
  description = "Number of application pod replicas."
  type        = number
  default     = 1

  validation {
    condition     = var.replicas >= 1 && floor(var.replicas) == var.replicas
    error_message = "replicas must be a positive whole number."
  }
}
