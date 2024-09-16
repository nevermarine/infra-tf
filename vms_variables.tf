variable "vm_vlan_id" {
  type        = number
  description = "VLAN ID for VM subnet"
}

variable "k8s_vlan_id" {
  type        = number
  description = "VLAN ID for Kubernetes subnet"
}

variable "vm_username" {
  type        = string
  description = "Username for user in VM modules"
}

variable "ssh_public_key" {
  type        = string
  description = "Path to SSH public key for use in VM modules"
}
