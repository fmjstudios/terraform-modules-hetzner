output "id" {
  value = {
    for k, v in hcloud_rdns.current : k => v.id
  }
  description = "The unique ID of the Hetzner Cloud reverse DNS entry."
}

output "dns_ptr" {
  value = {
    for k, v in hcloud_rdns.current : k => v.dns_ptr
  }
  description = "The Hetzner Cloud DNS pointer for the IP address."
}

output "ip_address" {
  value = {
    for k, v in hcloud_rdns.current : k => v.ip_address
  }
  description = "The IP address the Hetzner Cloud DNS entry should point to."
}

output "server_id" {
  value = {
    for k, v in hcloud_rdns.current : k => v.server_id
  }
  description = "The unique ID for the server the IP address belongs to."
}

output "primary_ip_id" {
  value = {
    for k, v in hcloud_rdns.current : k => v.primary_ip_id
  }
  description = "The unique ID for the primary IP the IP address belongs to."
}

output "floating_ip_id" {
  value = {
    for k, v in hcloud_rdns.current : k => v.floating_ip_id
  }
  description = "The unique ID for the floating IP the IP address belongs to."
}

output "load_balancer_id" {
  value = {
    for k, v in hcloud_rdns.current : k => v.load_balancer_id
  }
  description = "The unique ID for the load balancer the IP address belongs to."
}
