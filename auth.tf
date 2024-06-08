variable "username" {
  type        = string
  description = "Proxmox Web UI username"
}

variable "password" {
  type        = string
  description = "Proxmox Web UI password"
}

variable "ssh_key" {
  type        = string
  description = "Path to SSH private key for Proxmox node"
}

variable "ssh_username" {
  type        = string
  description = "SSH username for Proxmox node"
}

variable "proxmox_endpoint" {
  type        = string
  description = "Endpoint to Proxmox Web UI"
}
