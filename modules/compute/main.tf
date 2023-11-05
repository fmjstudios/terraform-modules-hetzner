locals {
  x86_intel_types     = ["cx11", "cx21", "cx31", "cx41", "cx51"]
  x86_amd_types       = ["cpx11", "cpx21", "cpx31", "cpx41", "cpx51"]
  x86_dedicated_types = ["ccx13", "ccx23", "ccx33", "ccx43", "ccx53", "ccx63"]

  arm_types = ["cax11", "cax21", "cax31", "cax41"]
  x86_types = concat(local.x86_intel_types, local.x86_amd_types, local.x86_dedicated_types)
}

#--------------------------------------
# OS Image
#--------------------------------------

locals {
  is_x86 = contains(local.x86_types, var.type)
  is_arm = contains(local.arm_types, var.type)

  arch = local.is_x86 ? "x86" : "arm"
}

data "hcloud_image" "os" {
  name              = var.image
  with_architecture = local.arch
}

#--------------------------------------
# Machine Location
#--------------------------------------

locals {
  datacenter_map = {
    ash = {
      suffix = "dc1"
    }

    hil = {
      suffix = "dc1"
    }

    hel1 = {
      suffix = "dc2"
    }

    nbg1 = {
      suffix = "dc3"
    }

    fsn1 = {
      suffix = "dc14"
    }
  }

  suffixed_datacenter = format("${var.location}-%s", local.datacenter_map[var.location].suffix)
}


#--------------------------------------
# Cloud-Init configuration
#--------------------------------------

data "cloudinit_config" "cloud_config" {
  gzip          = var.cloud_init["gzip"]
  base64_encode = var.cloud_init["base64_encode"]

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"
    content      = yamlencode(var.cloud_init["config"])
  }
}

#--------------------------------------
# Compute Instance
#--------------------------------------

data "hcloud_images" "remote_images" {
  with_architecture = [local.arch]
}

data "hcloud_server_type" "current_type" {
  name = var.type
}

data "hcloud_datacenter" "current" {
  name = local.suffixed_datacenter
}


resource "hcloud_server" "current" {
  # count = var.create_server ? 1 : 0

  name        = var.name
  server_type = var.type
  image       = data.hcloud_image.os.id
  location    = var.location

  user_data = data.cloudinit_config.cloud_config.rendered

  ssh_keys = try(var.ssh_keys, [])

  keep_disk = var.keep_disk
  iso       = var.iso
  rescue    = var.rescue
  labels    = var.labels

  backups                    = var.backups
  firewall_ids               = var.firewall_ids
  ignore_remote_firewall_ids = var.ignore_remote_firewall_ids

  placement_group_id = var.placement_group_id

  delete_protection  = var.enable_protection
  rebuild_protection = var.enable_protection

  allow_deprecated_images = false
  # shutdown_before_deletion = var.shutdown_before_deletion

  dynamic "public_net" {
    for_each = var.networking != {} ? [1] : []

    content {
      ipv4         = try(var.networking["ipv4"], null)
      ipv4_enabled = try(var.networking["ipv4_enabled"], true)
      ipv6         = try(var.networking["ipv6"], null)
      ipv6_enabled = try(var.networking["ipv6_enabled"], true)
    }
  }

  dynamic "network" {
    for_each = var.private_network != {} ? [1] : []

    content {
      alias_ips  = try(var.private_network["alias_ips"], [""])
      ip         = try(var.private_network["ip"], null)
      network_id = try(var.private_network["network_id"], null)
    }
  }

  lifecycle {
    ignore_changes = [ssh_keys]

    precondition {
      condition     = contains(data.hcloud_images.remote_images.images[*].name, var.image)
      error_message = "Hetzner Cloud does not have your requested OS image: '${var.image}'. Please be sure to create a snapshot of a custom image first, or upload the custom image manually."
    }

    precondition {
      condition     = contains(data.hcloud_datacenter.current.supported_server_type_ids, data.hcloud_server_type.current_type.id)
      error_message = "The Hetzner Cloud location you chose does not support the server type you chose! Please switch to another server type or location to continue."
    }
  }
}
