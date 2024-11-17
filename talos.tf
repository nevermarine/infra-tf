locals {
  talos_worker_name       = "patroclus"
  talos_master_name       = "achilles"
  talos_k8s_start_id      = 251
  talos_worker_cpu        = 4
  talos_worker_ram        = 4096
  talos_worker_main_disk  = 20
  talos_worker_data_disk  = 30
  talos_worker_count      = 3
  talos_master_cpu        = 2
  talos_master_ram        = 4096
  talos_master_disk       = 30
  talos_master_count      = 3
  talos_k8s_initial_cidr  = "10.0.0.0/24"
  talos_k8s_subnet_offset = 31
  talos_image             = "local:iso/nocloud-amd64.iso"
  talos_master_tags       = ["talos", "talos-master"]
  talos_worker_tags       = ["talos", "talos-worker"]
}

resource "proxmox_virtual_environment_vm" "talos_master" {
  count     = local.talos_master_count
  name      = "${local.talos_master_name}${count.index + 1}"
  node_name = var.target_node
  vm_id     = local.talos_k8s_start_id + count.index
  tags      = local.talos_master_tags

  cpu {
    architecture = "x86_64"
    type         = "x86-64-v3"
    cores        = local.talos_master_cpu
    sockets      = 1
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = local.talos_master_ram
  }

  network_device {
    bridge = "VM"
    # vlan_id = var.k8s_vlan_id
  }
  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${cidrhost(local.talos_k8s_initial_cidr, local.talos_k8s_subnet_offset + count.index)}/24"
        gateway = var.vm_gw
      }
    }
    dns {
      servers = [var.vm_gw, "8.8.8.8"]
      domain  = var.dns_search_domain
    }
    # user_data_file_id = proxmox_virtual_environment_file.talos_master[count.index].id
  }

  cdrom {
    enabled   = true
    file_id   = local.talos_image
    interface = "ide0"
  }

  disk {
    size        = local.talos_master_disk
    file_format = "raw"
    # file_id      = local.talos_image
    datastore_id = "local-lvm"
    interface    = "scsi0"
  }
  # boot_order = ["scsi0"]
}

resource "mikrotik_dns_record" "talos_master" {
  count   = local.talos_master_count
  name    = "${local.talos_master_name}${count.index + 1}.home"
  address = cidrhost(local.talos_k8s_initial_cidr, local.talos_k8s_subnet_offset + count.index)
}

resource "proxmox_virtual_environment_vm" "talos_worker" {
  count     = local.talos_worker_count
  name      = "${local.talos_worker_name}${count.index + 1}"
  node_name = var.target_node
  vm_id     = local.talos_k8s_start_id + local.talos_master_count + count.index
  tags      = local.talos_worker_tags

  cpu {
    architecture = "x86_64"
    type         = "x86-64-v2-AES"
    cores        = local.talos_worker_cpu
    sockets      = 1
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = local.talos_worker_ram
  }

  network_device {
    bridge = "VM"
    # vlan_id = var.k8s_vlan_id
  }
  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${cidrhost(local.talos_k8s_initial_cidr, local.talos_k8s_subnet_offset + local.talos_master_count + count.index)}/24"
        gateway = var.vm_gw
      }
    }
    dns {
      servers = [var.vm_gw, "8.8.8.8"]
      domain  = var.dns_search_domain
    }
    # user_data_file_id = proxmox_virtual_environment_file.talos_worker[count.index].id
  }

  cdrom {
    enabled   = true
    file_id   = local.talos_image
    interface = "ide0"
  }

  disk {
    size         = local.talos_worker_main_disk
    file_format  = "raw"
    datastore_id = "local-lvm"
    interface    = "scsi0"
  }

  disk {
    size         = local.talos_worker_data_disk
    file_format  = "raw"
    datastore_id = "local-lvm"
    interface    = "scsi1"
  }
  # boot_order = ["scsi0"]
}

resource "mikrotik_dns_record" "talos_worker" {
  count   = local.talos_worker_count
  name    = "${local.talos_worker_name}${count.index + 1}.home"
  address = cidrhost(local.talos_k8s_initial_cidr, local.talos_k8s_subnet_offset + local.talos_master_count + count.index)
}
