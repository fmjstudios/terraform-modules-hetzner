# -----------------------------------------------
#  Hetzner Volume
# -----------------------------------------------

resource "hcloud_volume" "current" {
  name              = var.name
  size              = var.size
  location          = var.location
  format            = var.format
  delete_protection = var.delete_protection
}

# -----------------------------------------------
#  Hetzner Volume Attachment
# -----------------------------------------------

resource "hcloud_volume_attachment" "current" {
  volume_id = hcloud_volume.current.id
  server_id = var.server_id
  automount = var.automount
}
