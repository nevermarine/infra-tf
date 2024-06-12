resource "proxmox_virtual_environment_vm" "vm" {
  name      = var.name
  node_name = var.node_name
  vm_id     = var.vm_id

  cpu {
    type    = var.cpu_type
    cores   = var.size.cores
    sockets = var.size.sockets
  }

  agent {
    enabled = var.agent
  }

  memory {
    dedicated = var.size.memory
  }

  network_device {
    bridge  = var.net.bridge
    vlan_id = var.net.vlan_id
  }
  operating_system {
    type = var.os_type
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.net.addr
        gateway = var.net.gw
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  disk {
    datastore_id = var.disk.datastore_id
    file_id      = var.disk.file_id
    interface    = var.disk.interface
    size         = var.size.disk

  }

  dynamic "disk" {
    for_each = var.passthrough_disk
    content {
      datastore_id      = ""
      interface         = "sata${index(var.passthrough_disk, disk.value)}"
      path_in_datastore = disk.value.path
      size              = disk.value.size
      file_format       = "raw"
    }
  }

  boot_order = [var.disk.interface]
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = var.disk.ci_datastore_id
  node_name    = var.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${var.name}
    fqdn: ${var.name}.home
    users:
      - name: ${var.default_user.name}
        ssh_authorized_keys:
          - ${var.default_user.ssh_key}
        groups:
          - sudo
        shell: /bin/bash
        sudo: ALL=(ALL) NOPASSWD:ALL
    runcmd:
    ${length(local.formatted_commands) > 0 ? "${join("\n", local.formatted_commands)}\n" : ""}    - sed -i 's/^SELINUX=.*$/SELINUX=disabled/' /etc/selinux/config
        - setenforce 0
        - yum update  -y
        - yum install -y epel-release
        - yum install -y ${join(" ", var.packages)}
        - echo "done" > /tmp/cloud-config.done
    timezone: ${var.timezone}
    EOF

    file_name = "cloud-config-${var.name}-${var.vm_id}.yaml"
  }
}
