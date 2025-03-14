terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = "your_token"
  cloud_id  = "your_ cloud_id"
  folder_id = "your_folder_id"
  zone      = "your_zone"
}

resource "yandex_compute_disk" "boot-disk-1" {
  name     = "boot-disk-1"
  type     = "network-ssd"
  zone     = "ru-central1-b"
  size     = "20"
  image_id = "fd866kfu2hbk46j2e21q"
}

resource "yandex_compute_instance" "vm-1" {
  name = "prod-server"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-1.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "jenkins:${file("/var/lib/jenkins/.ssh/id_rsa.pub")}" # Add Jenkins SSH key for access
    user-data = <<-EOF
      #cloud-config
      users:
        - name: jenkins # Create a user named 'jenkins'
          sudo: ALL=(ALL) NOPASSWD:ALL 
          shell: /bin/bash # Set the default shell
          ssh_authorized_keys:
            - ${file("/var/lib/jenkins/.ssh/id_rsa.pub")} 
      EOF
 }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_prod-stand" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}


output "external_ip_address_prod-stand" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}
