# module "almalinux9" {
#   source          = "./modules/image"
#   image_url       = "https://mirror.yandex.ru/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-latest.x86_64.qcow2"
#   image_file_name = "almalinux9.3.qcow2.img"
#   target_node     = var.target_node
# }
# module "fedora40" {
#   source          = "./modules/image"
#   image_url       = "https://mirror.yandex.ru/fedora/linux/releases/40/Cloud/x86_64/images/Fedora-Cloud-Base-Generic.x86_64-40-1.14.qcow2"
#   image_file_name = "fedora40.qcow2.img"
#   target_node     = var.target_node
# }
