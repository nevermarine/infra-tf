terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.54.0"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    region = "ru-central1"
    key    = "terraform.tfstate"
    # bucket = var.tfstate_bucket

    # Those are required because terraform validates against aws
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true

  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.username
  password = var.password
  insecure = true
  tmp_dir  = "/var/tmp"
  ssh {
    username    = var.ssh_username
    agent       = true
    private_key = file(var.ssh_key)
  }
}