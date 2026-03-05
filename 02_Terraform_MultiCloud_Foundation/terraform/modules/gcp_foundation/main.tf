resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name_prefix}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  project       = var.project_id
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.name_prefix}-allow-ssh"
  network = google_compute_network.vpc.name
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.allowed_ssh_cidr]
}

resource "google_compute_instance" "vm" {
  name         = "${var.name_prefix}-vm"
  machine_type = var.machine_type
  zone         = "${var.region}-b"
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {}
  }

  metadata = {
    ssh-keys = "mcadmin:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = "US"
  project       = var.project_id
  force_destroy = true
  uniform_bucket_level_access = true
}

output "network" { value = google_compute_network.vpc.name }
output "vm_public_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}
output "bucket_name" { value = google_storage_bucket.bucket.name }
