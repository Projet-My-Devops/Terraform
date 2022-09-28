terraform {
  required_providers {
    proxmox = {
        source = "Telmate/proxmox"
        version = "2.9.6"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.1.2:8006/api2/json"
  pm_user = "terraform-pro@pve"
  pm_password = "terraform"
}

resource "proxmox_vm_qemu" "resource-name" {
  name = "TOOLS"
  target_node = "factory"
  clone = "TEMPLATE"
  memory = 4096
  oncreate = true
  onboot = true
  pool = "Projet-Ydays"
  agent = 1
  nameserver = "192.168.10.253"
  network {
    bridge = "vmbr2"
    tag = 10
    firewall = false
    link_down = false
    model = "virtio"
  }
  disk {
    type = "virtio"
    storage = "DATA"
    size = "60G"
  }
}

output "instance_ips" {
  value = proxmox_vm_qemu.resource-name.default_ipv4_address
}