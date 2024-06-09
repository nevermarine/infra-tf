module "testvm" {
  source    = "./modules/cloud-init-vm"
  name      = "module-test-vm"
  vm_id     = "222"
  node_name = var.target_node
  size = {
    memory = 4096
    cores  = 6
    disk   = 30
  }
  default_user = {
    name    = var.vm_username
    ssh_key = file(var.ssh_public_key)
  }
  net = {
    vlan_id = var.vm_vlan_id
  }
  disk = {
    file_id      = module.almalinux9.image_id
    datastore_id = "local-lvm"
  }
}

module "NAS" {
  source    = "./modules/cloud-init-vm"
  name      = "nas"
  vm_id     = "200"
  node_name = var.target_node
  size = {
    memory = 8192
    cores  = 8
    disk   = 100
  }
  default_user = {
    name    = var.vm_username
    ssh_key = file(var.ssh_public_key)
  }
  net = {
    vlan_id = var.vm_vlan_id
    addr    = var.nas_addr
    gw      = var.vm_gw
  }
  disk = {
    file_id      = module.almalinux9.image_id
    datastore_id = "local-lvm"
  }
  # passthrough_disk = ["/dev/sda", "/dev/sdb"]
  passthrough_disk = [
    {
      path = "/dev/sda"
      size = 3726
    },
    {
      path = "/dev/sdb"
      size = 3726
    }
  ]
}
