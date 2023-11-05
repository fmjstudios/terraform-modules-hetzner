# -----------------------------------------------
#  Hetzner rDNS
# -----------------------------------------------

resource "hcloud_rdns" "current" {
  for_each = var.entries

  # These have to be defined
  dns_ptr    = each.value["dns_ptr"]
  ip_address = each.value["ip_address"]

  server_id        = try(each.value["server_id"], null)
  primary_ip_id    = try(each.value["primary_ip_id"], null)
  floating_ip_id   = try(each.value["floating_ip_id"], null)
  load_balancer_id = try(each.value["load_balancer_id"], null)
}
