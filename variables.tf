variable "target_node" {
  type = string
}
# variable "nas_addr" {
#   type = string
# }

# variable "dns_addr" {
#   type = string
# }
variable "vm_subnet" {
  type        = string
  description = "VM CIDR subnet. Needed only for DNS records"
}
variable "vm_gw" {
  type = string
}

variable "k8s_gw" {
  type = string
}

variable "dns_search_domain" {
  type = string
}
