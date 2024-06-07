variable "name" {
  type = string
}
variable "vm_id" {
  type = number
}
variable "node_name" {
  type = string
}
variable "cpu_type" {
  type    = string
  default = "x86-64-v2-AES"
}
variable "size" {
  type = object(
    {
      memory  = optional(number, 2048)
      cores   = optional(number, 2)
      sockets = optional(number, 1)
      disk    = optional(number, 30)
    }
  )
}
variable "net" {
  type = object(
    {
      addr = optional(string, "dhcp")
      gw   = optional(string)

      bridge  = optional(string, "vmbr1")
      vlan_id = optional(number)
    }
  )
}

variable "default_user" {
  type = object(
    {
      name = string
      # pass    = string
      ssh_key = string
    }
  )
}

variable "os_type" {
  type    = string
  default = "l26"
}

variable "disk" {
  type = object(
    {
      datastore_id    = optional(string, "local-lvm")
      ci_datastore_id = optional(string, "local")
      interface       = optional(string, "scsi0")
      file_id         = string
    }
  )
}
variable "agent" {
  type    = bool
  default = false
}

variable "timezone" {
  type    = string
  default = "Europe/Moscow"
}
