locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "google_compute_network" "main" {
  name                    = "vpc-${local.name_prefix}"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "main" {
  for_each      = var.subnets
  name          = "subnet-${local.name_prefix}-${each.key}"
  ip_cidr_range = each.value.cidr
  region        = each.value.region
  network       = google_compute_network.main.id
}

resource "google_compute_firewall" "allow_admin_ssh" {
  name    = "fw-${local.name_prefix}-allow-admin-ssh"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.allowed_admin_cidr]
  target_tags   = ["network-admin"]
}
