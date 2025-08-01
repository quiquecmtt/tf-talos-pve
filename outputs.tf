output "cluster_kubeconfig" {
  value     = module.talos_cluster.kubeconfig
  sensitive = true
}

output "cluster_talosconfig" {
  value     = module.talos_cluster.talosconfig
  sensitive = true
}

