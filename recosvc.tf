locals {
  recosvc_name     = "recosvc"
  recosvc_vm_id    = 902
  recosvc_cpu      = 4
  recosvc_ram      = 4096
  recosvc_disk     = 32
  recosvc_addr     = "10.0.1.50/24"
  recosvc_dns_addr = "10.0.1.50"
}
resource "proxmox_virtual_environment_vm" "recosvc" {
  name      = local.recosvc_name
  node_name = var.target_node
  vm_id     = local.recosvc_vm_id
  cpu {
    architecture = "x86_64"
    type         = "x86-64-v3"
    cores        = local.recosvc_cpu
    sockets      = 1
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = local.recosvc_ram
  }

  network_device {
    bridge = "k8s"
    # vlan_id = var.vm_vlan_id
  }
  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = local.recosvc_addr
        gateway = var.k8s_gw
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.recosvc.id
  }

  disk {
    size         = local.recosvc_disk
    file_id      = "local:iso/Rocky-9-GenericCloud-LVM-9.4-20240609.0.x86_64.qcow2.iso"
    datastore_id = "local-lvm"
    interface    = "scsi0"
  }
  boot_order = ["scsi0"]
}

resource "proxmox_virtual_environment_file" "recosvc" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${local.recosvc_name}
    fqdn: ${local.recosvc_name}.home
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

    file_name = "cloud-config-${local.recosvc_name}-${local.recosvc_vm_id}.yaml"
  }
}

resource "mikrotik_dns_record" "recosvc" {
  name    = "${local.recosvc_name}.home"
  address = local.recosvc_dns_addr
}
