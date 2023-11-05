module "volumes_example" {
  source = "../../modules/volume"

  name              = "example_volume-20G-xfs"
  size              = 20     # default would be 10
  location          = "ngb1" # default is 'fsn1'
  format            = "xfs"  # default is 'ext4'
  delete_protection = false  # enabled by default

  server_id = 0
  automount = false # enabled by default
}
