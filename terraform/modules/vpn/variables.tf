variable "project_id" {
  description = "Google Cloud project hosting the VPN gateway."
  type        = string
}

variable "region" {
  description = "Region hosting the VPN gateway."
  type        = string
}

variable "cluster_name" {
  description = "Name prefix for VPN resources."
  type        = string
}

variable "network_id" {
  description = "ID of the virtual private cloud network attached to the VPN gateway."
  type        = string
}
