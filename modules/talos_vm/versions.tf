terraform {
  required_version = ">= 1.10.3"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.80.0"
    }
  }
}


