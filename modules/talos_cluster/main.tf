resource "talos_machine_secrets" "this" {}

data "talos_machine_configuration" "per_vm" {
  for_each = var.vm_definitions

  cluster_name     = var.cluster_name
  machine_type     = each.value.machine_type
  cluster_endpoint = var.cluster_endpoint
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_client_configuration" "per_vm" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes                = values(var.vm_definitions)[*].ip_address
}

resource "talos_machine_configuration_apply" "per_vm" {
  for_each                    = var.vm_definitions
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.per_vm[each.key].machine_configuration
  node                        = each.value.ip_address
  config_patches = [
    yamlencode({
      machine = {
        install = {
          disk  = "/dev/sda"
          image = "factory.talos.dev/nocloud-installer/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586:v1.10.5"
        }
      }
    })
  ]
}

resource "talos_machine_bootstrap" "this" {
  for_each = {
    for i, pair in slice([
      for k, v in var.vm_definitions : {
        key = k
        vm  = v
      } if v.machine_type == "controlplane"
    ], 0, 1) : pair.key => pair.vm
  }

  depends_on = [
    talos_machine_configuration_apply.per_vm["talos-m1"],
  ]

  node                 = each.value.ip_address
  client_configuration = data.talos_client_configuration.per_vm.client_configuration

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "talos_cluster_kubeconfig" "this" {
  for_each = {
    for i, pair in slice([
      for k, v in var.vm_definitions : {
        key = k
        vm  = v
      } if v.machine_type == "controlplane"
    ], 0, 1) : pair.key => pair.vm
  }

  depends_on = [
    talos_machine_bootstrap.this
  ]

  node                 = each.value.ip_address
  client_configuration = data.talos_client_configuration.per_vm.client_configuration
}

# resource "local_file" "talosconfig" {
#   content  = data.talos_client_configuration.per_vm.client_configuration
#   filename = "${path.module}/talosconfig"
# }

# resource "local_file" "kubeconfig" {
#   content  = data.talos_client_configuration.per_vm.kubeconfig
#   filename = "${path.module}/kubeconfig"
# }

