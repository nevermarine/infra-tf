module "almalinux9" {
  source    = "./modules/image"
  image_url       = "https://repo.almalinux.org/almalinux/9/cloud/x86_64/images/AlmaLinux-9-GenericCloud-9.3-20231113.x86_64.qcow2"
  image_file_name = "almalinux9.3.qcow2.img"
}