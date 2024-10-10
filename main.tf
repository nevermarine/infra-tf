terraform {
  required_version = ">= 1.8.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.66.1"
    }
    mikrotik = {
      source  = "ddelnano/mikrotik"
      version = "0.16.1"
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

provider "mikrotik" {
  host           = var.mikrotik_host
  username       = var.mikrotik_username
  password       = var.mikrotik_password
  ca_certificate = var.mikrotik_cert
  tls            = true
  insecure       = false
}
