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
  pm_user = "terraform-prov@pve"
  pm_password = "terraform"
}

resource "proxmox_vm_qemu" "resource-name" {
  name = "BACKUP"
  target_node = "factory"
  clone = "TEMPLATE"
  cores = 1
  memory = 4096
  oncreate = true
  onboot = true
  pool = "Projet-Ydays"
  agent = 1
  ipconfig0 = "gw=192.168.10.254,ip=192.168.10.5/24"
  nameserver = "192.168.10.253"
  bootdisk = "scsi0"
  full_clone = true
  network {
    bridge = "vmbr2"
    tag = 10
    firewall = false
    link_down = false
    model = "virtio"
  }
  disk {
    type = "scsi"
    storage = "DATA"
    size = "60G"
  }
}

output "instance_ips" {
  value = proxmox_vm_qemu.resource-name.default_ipv4_address
}