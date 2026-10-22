variable "project_id" {
  description = "The Google Cloud project ID to deploy resources into."
  type        = string
}

variable "region" {
  description = "The Google Cloud region to deploy regional resources into."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Name used for the Google Kubernetes Engine cluster and related resources."
  type        = string
  default     = "sandbox-gke"
}

variable "app_repository_name" {
  description = "Artifact Registry repository name for the application container image."
  type        = string
  default     = "gcp-sandbox-app"
}

variable "cluster_location" {
  description = "Zone or region for the Google Kubernetes Engine cluster; the default is zonal to limit sandbox costs."
  type        = string
  default     = "us-central1-a"
}

variable "subnet_cidr" {
  description = "Primary IPv4 range for the cluster subnet; verify it does not overlap with remote VPN networks."
  type        = string
  default     = "10.80.0.0/20"
}

variable "pod_cidr" {
  description = "Secondary IPv4 range for Google Kubernetes Engine pods; verify it does not overlap with remote VPN networks."
  type        = string
  default     = "10.84.0.0/16"
}

variable "service_cidr" {
  description = "Secondary IPv4 range for Google Kubernetes Engine services; verify it does not overlap with remote VPN networks."
  type        = string
  default     = "10.85.0.0/20"
}

variable "control_plane_cidr" {
  description = "Private IPv4 range reserved for the cluster control plane."
  type        = string
  default     = "172.16.0.0/28"
}

variable "node_count" {
  description = "Number of worker nodes in the cluster's node pool."
  type        = number
  default     = 1

  validation {
    condition     = var.node_count >= 1 && floor(var.node_count) == var.node_count
    error_message = "node_count must be a positive whole number."
  }
}

variable "node_machine_type" {
  description = "Compute Engine machine type for each worker node."
  type        = string
  default     = "e2-standard-2"
}

variable "cloud_router_asn" {
  description = "Private Border Gateway Protocol autonomous system number for the Cloud Router."
  type        = number
  default     = 64514

  validation {
    condition     = var.cloud_router_asn >= 64512 && var.cloud_router_asn <= 65534
    error_message = "cloud_router_asn must be in the private 16-bit range 64512-65534."
  }
}
