variable "project_id" {
  description = "Google Cloud project hosting the network."
  type        = string
}

variable "region" {
  description = "Region hosting the subnet, Cloud Router, and Cloud Network Address Translation."
  type        = string
}

variable "cluster_name" {
  description = "Name prefix for network resources."
  type        = string
}

variable "subnet_cidr" {
  description = "Primary IPv4 range for the subnet."
  type        = string
}

variable "pod_cidr" {
  description = "Secondary IPv4 range for cluster pods."
  type        = string
}

variable "service_cidr" {
  description = "Secondary IPv4 range for cluster services."
  type        = string
}

variable "cloud_router_asn" {
  description = "Private Border Gateway Protocol autonomous system number for the Cloud Router."
  type        = number
}
