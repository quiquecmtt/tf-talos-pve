provider "proxmox" {
  alias    = "prox1"
  endpoint = "https://${local.prox1_ip}:8006/api2/json"
  username = "root@pam"
  password = local.prox1_password
  insecure = true
  ssh {
    username = "root"
  }
}

provider "proxmox" {
  alias    = "prox2"
  endpoint = "https://${local.prox2_ip}:8006/api2/json"
  username = "root@pam"
  password = local.prox2_password
  insecure = true
  ssh {
    username = "root"
  }
}

provider "proxmox" {
  alias    = "prox3"
  endpoint = "https://${local.prox3_ip}:8006/api2/json"
  username = "root@pam"
  password = local.prox3_password
  insecure = true
  ssh {
    username = "root"
    node {
      name    = "prox-3"
      address = local.prox3_ip
    }
  }
}

