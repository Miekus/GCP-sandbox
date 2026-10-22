module "network" {
  source = "./network"

  project_id       = var.project_id
  region           = var.region
  cluster_name     = var.cluster_name
  subnet_cidr      = var.subnet_cidr
  pod_cidr         = var.pod_cidr
  service_cidr     = var.service_cidr
  cloud_router_asn = var.cloud_router_asn
}

module "cluster" {
  source = "./cluster"

  project_id         = var.project_id
  cluster_name       = var.cluster_name
  cluster_location   = var.cluster_location
  network_id         = module.network.network_id
  subnetwork_id      = module.network.subnetwork_id
  pod_range_name     = module.network.pod_range_name
  service_range_name = module.network.service_range_name
  control_plane_cidr = var.control_plane_cidr
  node_count         = var.node_count
  node_machine_type  = var.node_machine_type
}

module "artifact_registry" {
  source = "./artifact_registry"

  project_id      = var.project_id
  region          = var.region
  repository_name = var.app_repository_name
}

module "vpn" {
  source = "./vpn"

  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name
  network_id   = module.network.network_id
}
