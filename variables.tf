variable "prox_default_password" {
  description = "Default password for Proxmox endpoints"
  type        = string
  sensitive   = true
}

variable "iso_url" {
  description = "Talos ISO URL"
  type        = string
  sensitive   = false
}

variable "cluster_endpoint" {
  description = "Talos cluster control plane endpoint"
  type        = string
  sensitive   = false
  default     = "https://192.168.1.161:6443"
}

variable "cluster_name" {
  description = "Talos cluster name"
  type        = string
  sensitive   = false
  default     = "talos-pve"
}

variable "vm_definitions" {
  type = map(object({
    node         = string
    memory       = number
    vmid         = number
    ip_address   = string
    ip_gateway   = string
    ip_subnet    = number
    machine_type = string
  }))
  default = {
    "talos-m1" = {
      node         = "prox-1"
      memory       = 4096
      vmid         = 161
      ip_address   = "192.168.1.161"
      ip_subnet    = 24
      ip_gateway   = "192.168.1.254"
      machine_type = "controlplane"
    },
    "talos-m2" = {
      node         = "prox-2"
      memory       = 4096
      vmid         = 162
      ip_address   = "192.168.1.162"
      ip_subnet    = 24
      ip_gateway   = "192.168.1.254"
      machine_type = "controlplane"
    },
    "talos-m3" = {
      node         = "prox-3"
      memory       = 4096
      vmid         = 163
      ip_address   = "192.168.1.163"
      ip_subnet    = 24
      ip_gateway   = "192.168.1.254"
      machine_type = "controlplane"
    },
    "talos-w1" = {
      node         = "prox-1"
      memory       = 4096
      vmid         = 164
      ip_address   = "192.168.1.164"
      ip_subnet    = 24
      ip_gateway   = "192.168.1.254"
      machine_type = "worker"
    },
    "talos-w2" = {
      node         = "prox-2"
      memory       = 4096
      vmid         = 165
      ip_address   = "192.168.1.165"
      ip_subnet    = 24
      ip_gateway   = "192.168.1.254"
      machine_type = "worker"
    },
    "talos-w3" = {
      node         = "prox-3"
      memory       = 4096
      vmid         = 166
      ip_address   = "192.168.1.166"
      ip_subnet    = 24
      ip_gateway   = "192.168.1.254"
      machine_type = "worker"
    }
  }
}

