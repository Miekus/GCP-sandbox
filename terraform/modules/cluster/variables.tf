variable "project_id" {
  description = "Google Cloud project hosting the cluster."
  type        = string
}

variable "cluster_name" {
  description = "Name of the Google Kubernetes Engine cluster."
  type        = string
}

variable "cluster_location" {
  description = "Zone or region hosting the Google Kubernetes Engine cluster."
  type        = string
}

variable "network_id" {
  description = "ID of the virtual private cloud network for the cluster."
  type        = string
}

variable "subnetwork_id" {
  description = "ID of the subnet for the cluster."
  type        = string
}

variable "pod_range_name" {
  description = "Name of the subnet secondary range for cluster pods."
  type        = string
}

variable "service_range_name" {
  description = "Name of the subnet secondary range for cluster services."
  type        = string
}

variable "control_plane_cidr" {
  description = "Private IPv4 range reserved for the cluster control plane."
  type        = string
}

variable "node_count" {
  description = "Number of worker nodes in the cluster node pool."
  type        = number
}

variable "node_machine_type" {
  description = "Compute Engine machine type for each worker node."
  type        = string
}
