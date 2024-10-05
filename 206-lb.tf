locals {
  name  = "lb"
  vm_id = 206
  cpu   = 2
  ram   = 2048
  disk  = 30
  addr  = "10.0.0.4/24"
}
resource "proxmox_virtual_environment_vm" "lb" {
  name      = local.name
  node_name = var.target_node
  vm_id     = local.vm_id

  cpu {
    type    = "x86-64-v2-AES"
    cores   = local.cpu
    sockets = 1
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = local.ram
  }

  network_device {
    bridge  = "vmbr1"
    vlan_id = var.vm_vlan_id
  }
  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = local.addr
        gateway = var.vm_gw
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.lb.id
  }

  disk {
    size         = local.disk
    file_id      = "local:iso/almalinux9.3.qcow2.img"
    datastore_id = "local-lvm"
    interface    = "scsi0"
  }
  boot_order = ["scsi0"]
}

resource "proxmox_virtual_environment_file" "lb" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${local.name}
    fqdn: ${local.name}.home
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

    file_name = "cloud-config-${local.name}-${local.vm_id}.yaml"
  }
}
