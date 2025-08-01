terraform {
  required_version = ">= 1.10.3"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.80.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.9.0-alpha.0"
    }
  }
}

