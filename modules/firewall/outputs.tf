output "id" {
  value       = hcloud_firewall.current.id
  description = "The unique ID for the new Hetzner Cloud firewall."
}

output "name" {
  value       = hcloud_firewall.current.name
  description = "The name for the new Hetzner Cloud firewall."
}

output "labels" {
  value       = hcloud_firewall.current.labels
  description = "The labels for the new Hetzner Cloud firewall."
}

output "rules" {
  value       = hcloud_firewall.current.rule
  description = "The rules for the new Hetzner Cloud firewall."
}

output "apply_to" {
  value       = hcloud_firewall.current.apply_to
  description = "The 'apply_to' configuration for the new Hetzner Cloud firewall."
}
