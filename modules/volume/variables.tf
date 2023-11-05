variable "name" {
  type        = string
  description = "The name to give to the new Hetzner Cloud volume."
}

variable "size" {
  type        = number
  description = "An integer denoting the size of the volume in Gigabytes. Default is 10."
  default     = 10
}

variable "location" {
  type        = string
  description = "The location for the new Hetzner Cloud volume. This is enforced since it automatically disallows the use of 'server_id' within the 'hcloud_volume' resource so that volumes do NOT get coupled to servers, but instead remain their own separately manageable resource. Default is 'fsn1' and other possible values are 'nbg1', 'hel1', 'ash' or 'hil'."
  default     = "fsn1"
}


variable "format" {
  type        = string
  description = "The type of format to use for the cloud volume. Default is 'ext4'."
  default     = "ext4"
}

variable "delete_protection" {
  type        = bool
  description = "Whether or not to enable delete protection for cloud volume. Default is 'true'."
  default     = true
}

# -------------------------------------
# Custom Variables
# -------------------------------------

variable "server_id" {
  type        = number
  description = "The ID of the Hetzner Cloud server to attach the volume to. This is exclusively used with the 'hcloud_volume_attachment' resource as not to couple servers and volumes like explained within the 'location' variable description. Default is 'null' in order to allow un-attached volumes to be created."
  default     = null
}

variable "automount" {
  type        = bool
  description = "Whether or not to automount the volume after attaching it within Hetzner Cloud. This is exclusively used within the 'hcloud_volume_attachment' resource as not to couple servers. Default is 'true'."
  default     = true
}
