output "vpc_name" { value = google_compute_network.main.name }
output "subnet_names" { value = { for k, v in google_compute_subnetwork.main : k => v.name } }
output "firewall_rule_name" { value = google_compute_firewall.allow_admin_ssh.name }
