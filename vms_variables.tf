variable "vm_username" {
  type        = string
  description = "Username for user in VM modules"
}

variable "ssh_public_key" {
  type        = string
  description = "Path to SSH public key for use in VM modules"
}
