locals {
  nestor_name  = "nestor"
  nestor_vm_id = 260
  nestor_cpu   = 4
  nestor_ram   = 4096
  nestor_disk  = 30
  nestor_ip    = "10.0.0.40"
  nestor_image = proxmox_virtual_environment_download_file.talos_data_image.id
}

resource "null_resource" "nestor_trigger" {
  triggers = {
    talos_data_image = proxmox_virtual_environment_vm.nestor.cdrom[0].file_id
  }
}

data "talos_image_factory_urls" "data_image" {
  talos_version = "v1.9.3"
  schematic_id  = "ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515"
  platform      = "nocloud"
}

resource "proxmox_virtual_environment_vm" "nestor" {
  name      = local.nestor_name
  node_name = var.target_node
  vm_id     = local.nestor_vm_id
  machine   = "q35" # magic value for PCIe passthrough

  cpu {
    architecture = "x86_64"
    type         = "x86-64-v3"
    cores        = local.nestor_cpu
    sockets      = 1
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = local.nestor_ram
  }

  network_device {
    bridge = "VM"
  }
  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${local.nestor_ip}/24"
        gateway = var.vm_gw
      }
    }
    dns {
      servers = [var.vm_gw, "8.8.8.8"]
      domain  = var.dns_search_domain
    }
    # user_data_file_id = proxmox_virtual_environment_file.nestor.id
  }

  cdrom {
    enabled   = true
    file_id   = local.nestor_image
    interface = "ide0"
  }

  disk {
    size         = local.nestor_disk
    file_id      = local.nestor_image
    datastore_id = "local-lvm"
    interface    = "scsi0"
  }

  # passthrough nvme
  hostpci {
    device = "hostpci0"
    id     = "0000:04:00.0"
    pcie   = true
  }
  boot_order = ["scsi0", "ide0"]
}

resource "talos_machine_configuration_apply" "machineconfig_nestor_appl" {
  depends_on                  = [proxmox_virtual_environment_vm.nestor]
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_worker.machine_configuration
  node                        = local.nestor_ip
  config_patches = [
    yamlencode({
      machine = {
        install = {
          disk  = "/dev/sda"
          image = data.talos_image_factory_urls.data_image.urls.installer
        }
        time = {
          servers = [
            "0.ru.pool.ntp.org",
            "1.ru.pool.ntp.org",
            "2.ru.pool.ntp.org",
            "3.ru.pool.ntp.org",
          ]
        }
        # nodeLabels = {
        #   role = "data"
        # }
        nodeTaints = {
          role = "data:NoSchedule"
        }
      }
    })
  ]
}

resource "mikrotik_dns_record" "nestor_master" {
  name    = local.nestor_name
  address = local.nestor_ip
}
