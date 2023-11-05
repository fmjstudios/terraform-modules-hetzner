module "rdns_example" {
  source = "../../modules/rdns"

  entries = {
    node1 = {
      dns_ptr    = "example.com"
      ip_address = hcloud_server.node1.ipv4_address
      server_id  = hcloud_server.node1.id
    }

    floating1 = {
      dns_ptr        = "example.com"
      ip_address     = hcloud_floating_ip.floating1.ip_address
      floating_ip_id = hcloud_floating_ip.floating1.id
    }

    primary1 = {
      dns_ptr       = "example.com"
      ip_address    = hcloud_primary_ip.primary1.ip_address
      primary_ip_id = hcloud_primary_ip.primary1.id
    }

    load_balancer1 = {
      dns_ptr          = "example.com"
      ip_address       = hcloud_load_balancer.load_balancer1.ipv4
      load_balancer_id = hcloud_load_balancer.load_balancer1.id
    }
  }
}

resource "hcloud_server" "node1" {
  name        = "node1"
  image       = "debian-11"
  server_type = "cx11"
}

resource "hcloud_floating_ip" "floating1" {
  home_location = "nbg1"
  type          = "ipv4"
}

resource "hcloud_primary_ip" "primary1" {
  datacenter = "nbg1-dc3"
  type       = "ipv4"

  auto_delete   = true
  assignee_type = "server"
}

resource "hcloud_load_balancer" "load_balancer1" {
  name               = "load_balancer1"
  load_balancer_type = "lb11"
  location           = "fsn1"
}

