variable "cluster_endpoint" {
  description = "Talos cluster control plane endpoint"
  type        = string
  sensitive   = false
}

variable "cluster_name" {
  description = "Talos cluster name"
  type        = string
  sensitive   = false
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
}

