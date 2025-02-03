locals {
  nestor_name  = "nestor"
  nestor_vm_id = 260
  nestor_cpu   = 4
  nestor_ram   = 4096
  nestor_disk  = 30
  nestor_ip    = "10.0.0.40"
  nestor_image = "local:iso/Rocky-9-GenericCloud-LVM-9.4-20240609.0.x86_64.qcow2.iso"
}

resource "proxmox_virtual_environment_vm" "nestor_master" {
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
    user_data_file_id = proxmox_virtual_environment_file.nestor.id
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
  boot_order = ["scsi0"]
}

resource "proxmox_virtual_environment_file" "nestor" {
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [source_raw]
  }
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${local.nestor_name}
    fqdn: ${local.nestor_name}.home
    users:
      - name: ${var.vm_username}
        ssh_authorized_keys:
          - ${file(var.ssh_public_key)}
        groups:
          - sudo
          - docker
        shell: /bin/bash
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    package_upgrade: true
    runcmd:
        - setenforce 0
        - sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
        - dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
        - yum install -y epel-release
        - yum install -y tmux vim htop iftop iotop fastfetch docker-ce
        - systemctl enable --now docker
        - echo "done" > /tmp/cloud-config.done
    timezone: Europe/Moscow
    EOF

    file_name = "cloud-config-${local.nestor_name}-${local.nestor_vm_id}.yaml"
  }
}

resource "mikrotik_dns_record" "nestor_master" {
  name    = local.nestor_name
  address = local.nestor_ip
}
