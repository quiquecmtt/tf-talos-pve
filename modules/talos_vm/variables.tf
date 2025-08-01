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
}

variable "iso_url" {
  description = "Talos ISO URL"
  type        = string
  sensitive   = false
}

variable "iso_node_name" {
  description = "Proxmox node where ISO is downloaded"
  type        = string
  sensitive   = false
}
