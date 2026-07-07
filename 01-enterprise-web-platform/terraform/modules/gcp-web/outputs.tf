output "network_name" {
  value = google_compute_network.main.name
}

output "subnet_name" {
  value = google_compute_subnetwork.web.name
}

output "firewall_rule_name" {
  value = google_compute_firewall.web.name
}
