module "talos_prox1" {
  source = "./modules/talos_vm"

  vm_definitions = {
    for k, v in var.vm_definitions : k => v if v.node == "prox-1"
  }

  iso_url       = var.iso_url
  iso_node_name = "prox-1"

  providers = {
    proxmox = proxmox.prox1
  }
}

module "talos_prox2" {
  source = "./modules/talos_vm"

  vm_definitions = {
    for k, v in var.vm_definitions : k => v if v.node == "prox-2"
  }

  iso_url       = var.iso_url
  iso_node_name = "prox-2"

  providers = {
    proxmox = proxmox.prox2
  }
}

module "talos_prox3" {
  source = "./modules/talos_vm"

  vm_definitions = {
    for k, v in var.vm_definitions : k => v if v.node == "prox-3"
  }

  iso_url       = var.iso_url
  iso_node_name = "prox-3"

  providers = {
    proxmox = proxmox.prox3
  }
}

resource "null_resource" "wait_for_vms" {
  depends_on = [
    module.talos_prox1,
    module.talos_prox2,
    module.talos_prox3
  ]
}

module "talos_cluster" {
  source     = "./modules/talos_cluster"
  depends_on = [null_resource.wait_for_vms]

  vm_definitions   = var.vm_definitions
  cluster_endpoint = var.cluster_endpoint
  cluster_name     = var.cluster_name

  providers = {
    talos = talos
  }
}
