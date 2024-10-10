locals {
  mon_name    = "sanae"
  mon_vm_id   = 211
  mon_cpu     = 4
  mon_ram     = 2048
  mon_disk    = 100
  mon_addr    = "10.0.0.25/24"
  mon_hostnum = 25
}
resource "proxmox_virtual_environment_vm" "sanae" {
  name      = local.mon_name
  node_name = var.target_node
  vm_id     = local.mon_vm_id
  cpu {
    architecture = "x86_64"
    type         = "x86-64-v3"
    cores        = local.mon_cpu
    sockets      = 1
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = local.mon_ram
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
        address = local.mon_addr
        gateway = var.vm_gw
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.sanae.id
  }

  disk {
    size         = local.mon_disk
    file_id      = "local:iso/Rocky-9-GenericCloud-LVM-9.4-20240609.0.x86_64.qcow2.iso"
    datastore_id = "local-lvm"
    interface    = "scsi0"
  }
  boot_order = ["scsi0"]
}

resource "proxmox_virtual_environment_file" "sanae" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${local.mon_name}
    fqdn: ${local.mon_name}.home
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
        - yum install -y tmux vim htop iftop iotop fastfetch docker-ce bind-utils iperf3 netcat
        - systemctl enable --now docker
        - echo "done" > /tmp/cloud-config.done
    timezone: Europe/Moscow
    EOF

    file_name = "cloud-config-${local.mon_name}-${local.mon_vm_id}.yaml"
  }
}

resource "mikrotik_dns_record" "sanae" {
  name    = "${local.mon_name}.home"
  address = cidrhost(var.vm_subnet, local.mon_hostnum)
}
