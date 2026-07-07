resource "google_compute_network" "main" {
  name                    = "vpc-${var.project_name}-${var.environment}"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "web" {
  name          = "subnet-web-${var.project_name}-${var.environment}"
  ip_cidr_range = "10.30.1.0/24"
  region        = var.region
  network       = google_compute_network.main.id
}

resource "google_compute_firewall" "web" {
  name    = "fw-web-${var.project_name}-${var.environment}"
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}
