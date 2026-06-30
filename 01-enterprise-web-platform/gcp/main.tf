# GCP Enterprise Web Platform
resource "google_compute_firewall" "allow_web" {
  name    = "allow-enterprise-web"
  network = "default"
  allow { protocol = "tcp" ports = ["80", "443"] }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["enterprise-web"]
}
