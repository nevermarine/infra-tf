locals {
  worker_name       = "kworker"
  master_name       = "kmaster"
  k8s_start_id      = 301
  worker_cpu        = 4
  worker_ram        = 2048
  worker_disk       = 30
  worker_count      = 2
  master_cpu        = 2
  master_ram        = 4096
  master_disk       = 30
  master_count      = 1
  k8s_initial_cidr  = "10.0.1.0/24"
  k8s_subnet_offset = 11
}

resource "proxmox_virtual_environment_vm" "master" {
  count     = local.master_count
  name      = "${local.master_name}${count.index + 1}"
  node_name = var.target_node
  vm_id     = local.k8s_start_id + count.index

  cpu {
    architecture = "x86_64"
    type         = "x86-64-v2-AES"
    cores        = local.master_cpu
    sockets      = 1
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = local.master_ram
  }

  network_device {
    bridge = "k8s"
    # vlan_id = var.k8s_vlan_id
  }
  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${cidrhost(local.k8s_initial_cidr, local.k8s_subnet_offset + count.index)}/24"
        gateway = var.k8s_gw
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.master[count.index].id
  }

  disk {
    size         = local.master_disk
    file_id      = "local:iso/Rocky-9-GenericCloud-LVM-9.4-20240609.0.x86_64.qcow2.iso"
    datastore_id = "local-lvm"
    interface    = "scsi0"
  }
  boot_order = ["scsi0"]
}
resource "proxmox_virtual_environment_file" "master" {
  count        = local.master_count
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${local.master_name}${count.index + 1}
    fqdn: ${local.master_name}${count.index + 1}.home
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

    file_name = "cloud-config-${local.master_name}${count.index + 1}-${local.k8s_start_id + count.index}.yaml"
  }
}

resource "mikrotik_dns_record" "k8s_master" {
  count   = local.master_count
  name    = "${local.master_name}${count.index + 1}.home"
  address = cidrhost(local.k8s_initial_cidr, local.k8s_subnet_offset + count.index)
}

resource "proxmox_virtual_environment_vm" "worker" {
  count     = local.worker_count
  name      = "${local.worker_name}${count.index + 1}"
  node_name = var.target_node
  vm_id     = local.k8s_start_id + local.master_count + count.index

  cpu {
    architecture = "x86_64"
    type         = "x86-64-v2-AES"
    cores        = local.worker_cpu
    sockets      = 1
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = local.worker_ram
  }

  network_device {
    bridge = "k8s"
    # vlan_id = var.k8s_vlan_id
  }
  operating_system {
    type = "l26"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${cidrhost(local.k8s_initial_cidr, local.k8s_subnet_offset + local.master_count + count.index)}/24"
        gateway = var.k8s_gw
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.worker[count.index].id
  }

  disk {
    size         = local.worker_disk
    file_id      = "local:iso/Rocky-9-GenericCloud-LVM-9.4-20240609.0.x86_64.qcow2.iso"
    datastore_id = "local-lvm"
    interface    = "scsi0"
  }
  boot_order = ["scsi0"]
}
resource "proxmox_virtual_environment_file" "worker" {
  count        = local.worker_count
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.target_node

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${local.worker_name}${count.index + 1}
    fqdn: ${local.worker_name}${count.index + 1}.home
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

    file_name = "cloud-config-${local.worker_name}${count.index + 1}-${local.k8s_start_id + count.index}.yaml"
  }
}

resource "mikrotik_dns_record" "k8s_worker" {
  count   = local.worker_count
  name    = "${local.worker_name}${count.index + 1}.home"
  address = cidrhost(local.k8s_initial_cidr, local.k8s_subnet_offset + local.master_count + count.index)
}
