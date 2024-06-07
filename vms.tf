module "testvm" {
  source    = "./modules/cloud-init-vm"
  name      = "module-test-vm.home"
  vm_id     = "222"
  node_name = var.target_node
  size = {
    memory = 2048
    cores  = 4
    disk   = 30
  }
  default_user = {
    name    = var.vm_username
    ssh_key = var.ssh_key_contents
  }
  net = {
    vlan_id = var.vm_vlan_id
  }
  disk = {
    file_id      = module.almalinux9.image_id
    datastore_id = "local-lvm"
  }
}
