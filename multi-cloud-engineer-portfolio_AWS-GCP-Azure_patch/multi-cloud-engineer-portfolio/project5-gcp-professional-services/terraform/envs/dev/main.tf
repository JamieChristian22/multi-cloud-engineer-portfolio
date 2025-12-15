provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc" {
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name}-subnet"
  ip_cidr_range = "10.60.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
}

resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "${var.name}-repo"
  description   = "Docker images for Cloud Run service"
  format        = "DOCKER"
}

# Cloud Run service (expects you to push an image; default points to :latest)
locals {
  image_uri = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.repo.repository_id}/app:latest"
}

resource "google_cloud_run_v2_service" "svc" {
  name     = "${var.name}-svc"
  location = var.region

  template {
    containers {
      image = local.image_uri
      env { name = "CLOUD_PROVIDER" value = "gcp" }
      ports { container_port = 3000 }
    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }
}

resource "google_cloud_run_v2_service_iam_member" "public" {
  name     = google_cloud_run_v2_service.svc.name
  location = var.region
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "artifact_registry_repo" { value = google_artifact_registry_repository.repo.repository_id }
output "cloud_run_url" { value = google_cloud_run_v2_service.svc.uri }
output "default_image_uri" { value = local.image_uri }
