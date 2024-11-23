resource "proxmox_virtual_environment_download_file" "talos_image" {
  content_type = "iso"
  datastore_id = "local"
  file_name    = "talos-${data.talos_image_factory_urls.image.talos_version}.iso"
  node_name    = var.target_node
  url          = data.talos_image_factory_urls.image.urls.iso
}
