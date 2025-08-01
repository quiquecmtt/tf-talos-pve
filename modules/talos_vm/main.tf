resource "proxmox_virtual_environment_download_file" "talos_iso" {
  provider = proxmox

  content_type = "iso"
  datastore_id = "local"
  file_name    = "talos-nocloud.iso"
  node_name    = var.iso_node_name
  url          = var.iso_url

  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "proxmox_virtual_environment_vm" "talos_vm" {
  for_each = var.vm_definitions

  provider = proxmox

  name        = each.key
  description = "Managed by Terraform"
  tags        = ["terraform", "talos"]

  node_name = each.value.node
  vm_id     = each.value.vmid

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = true
  }
  # if agent is not enabled, the VM may not be able to shutdown properly, and may need to be forced off
  stop_on_destroy = true

  boot_order = ["scsi0", "ide2", "net0"]
  cpu {
    cores = 2
    type  = "x86-64-v2-AES" # recommended for modern CPUs
  }

  memory {
    dedicated = each.value.memory
    floating  = each.value.memory # set equal to dedicated to enable ballooning
  }

  cdrom {
    file_id   = proxmox_virtual_environment_download_file.talos_iso.id
    interface = "ide2"
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    iothread     = true
    size         = 10
    discard      = "on"
    ssd          = true
  }

  initialization {
    interface    = "ide1"
    datastore_id = "local-lvm"
    ip_config {
      ipv4 {
        address = "${each.value.ip_address}/${each.value.ip_subnet}"
        gateway = each.value.ip_gateway
      }
    }
  }


  network_device {
    bridge = "vmbr0"
  }

  operating_system {
    type = "l26"
  }

  scsi_hardware = "virtio-scsi-single"

  tpm_state {
    version = "v2.0"
  }

  serial_device {}

}
