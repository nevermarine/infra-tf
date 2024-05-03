
resource "proxmox_virtual_environment_download_file" "image" {
  content_type = var.content_type
  datastore_id = var.datastore_id
  node_name    = var.target_node
  url          = var.image_url
  file_name    = var.image_file_name
}