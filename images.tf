resource "proxmox_virtual_environment_download_file" "talos_image" {
  content_type = "iso"
  datastore_id = "local"
  file_name    = "talos-${data.talos_image_factory_urls.image.talos_version}.iso"
  node_name    = var.target_node
  url          = data.talos_image_factory_urls.image.urls.iso
}

resource "proxmox_virtual_environment_download_file" "rocky_lvm" {
  content_type = "iso"
  datastore_id = "local"
  file_name    = "rocky-9-lvm.iso"
  node_name    = var.target_node
  url          = "https://dl.rockylinux.org/pub/rocky/9/images/x86_64/Rocky-9-GenericCloud-LVM.latest.x86_64.qcow2"
}
