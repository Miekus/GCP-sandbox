resource "google_compute_ha_vpn_gateway" "sandbox" {
  name    = "${var.cluster_name}-vpn"
  project = var.project_id
  region  = var.region
  network = var.network_id
}
