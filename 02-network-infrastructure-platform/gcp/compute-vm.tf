resource "google_compute_instance" "web" {
  name         = "enterprise-web-vm"
  machine_type = "e2-medium"
  zone         = var.zone
  tags         = ["web-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network    = google_compute_network.enterprise.id
    subnetwork = google_compute_subnetwork.public.id
    access_config {}
  }

  metadata_startup_script = file("${path.module}/startup-nginx.sh")
}

output "web_external_ip" {
  value = google_compute_instance.web.network_interface[0].access_config[0].nat_ip
}
