locals {
  gpu_host_name  = "ran"
  gpu_host_vm_id = 210
  gpu_host_cpu   = 10
  gpu_host_ram   = 20480
  gpu_host_disk  = 200
  gpu_host_addr  = "10.0.0.20/24"
}
resource "proxmox_virtual_environment_vm" "ran" {
  name      = local.gpu_host_name
  node_name = var.target_node
  vm_id     = local.gpu_host_vm_id
  machine   = "q35" # magic value for PCIe passthrough
  cpu {
    architecture = "x86_64"
    type         = "x86-64-v3"
    cores        = local.gpu_host_cpu
    sockets      = 1
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = local.gpu_host_ram
  }

  network_device {
    bridge = "VM"
    # vlan_id = var.vm_vlan_id
  }
  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = local.gpu_host_addr
        gateway = var.vm_gw
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.ran.id
  }

  disk {
    size         = local.gpu_host_disk
    file_id      = "local:iso/Rocky-9-GenericCloud-LVM-9.4-20240609.0.x86_64.qcow2.iso"
    datastore_id = "local-lvm"
    interface    = "scsi0"
  }
  boot_order = ["scsi0"]
  hostpci {
    device = "hostpci0"
    id     = "0000:03:00.0"
    pcie   = true
  }
}

resource "proxmox_virtual_environment_file" "ran" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${local.gpu_host_name}
    fqdn: ${local.gpu_host_name}.home
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

    file_name = "cloud-config-${local.gpu_host_name}-${local.gpu_host_vm_id}.yaml"
  }
}
