variable "name" {
  type        = string
  description = "The name to give to the new Hetzner Cloud firewall."
}

variable "labels" {
  type        = map(string)
  description = "A map of labels to apply to the newly created Hetzner Cloud firewall."
}

# -------------------------------------
# Custom Variables
# -------------------------------------

variable "rules" {
  type        = any
  description = "The firewall rules to apply to the cloud firewall on creation."
  default     = {}
}

variable "apply" {
  type        = any
  description = "Label selectors or server to apply the new cloud firewall to."
  default     = {}
}
