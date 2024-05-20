module "almalinux9" {
  source          = "./modules/image"
  image_url       = "https://mirror.yandex.ru/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2"
  image_file_name = "almalinux9.3.qcow2.img"
  target_node     = var.target_node
}
