resource "google_project_service" "compute" {
  project            = var.project_id
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "sandbox" {
  name                    = "${var.cluster_name}-network"
  project                 = var.project_id
  auto_create_subnetworks = false
  depends_on              = [google_project_service.compute]
}

resource "google_compute_subnetwork" "sandbox" {
  name                     = "${var.cluster_name}-subnet"
  project                  = var.project_id
  region                   = var.region
  network                  = google_compute_network.sandbox.id
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.pod_cidr
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.service_cidr
  }
}

resource "google_compute_router" "sandbox" {
  name    = "${var.cluster_name}-router"
  project = var.project_id
  region  = var.region
  network = google_compute_network.sandbox.id

  bgp {
    asn = var.cloud_router_asn
  }
}

resource "google_compute_router_nat" "sandbox" {
  name                               = "${var.cluster_name}-nat"
  project                            = var.project_id
  region                             = var.region
  router                             = google_compute_router.sandbox.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
