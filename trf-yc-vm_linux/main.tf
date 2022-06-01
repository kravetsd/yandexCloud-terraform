provider "yandex" {}

locals {
  nat_public_ip = [for ip in yandex_compute_instance.this.network_interface : ip.nat_ip_address]
  private_ip    = [for ip in yandex_compute_instance.this.network_interface : ip.ip_address]
  vm-hostname   = var.vm-hostname != "" ? var.vm-hostname : var.vm-name
}

resource "yandex_compute_instance" "this" {
  labels = merge(var.additional_labels, {
    resource_type = "compute_instance"
    }
  )

  folder_id   = var.folder_id
  platform_id = var.vm-platform_id
  name        = var.vm-name
  hostname    = local.vm-hostname
  metadata = {
    serial_port_enabled = var.vm-serial_port_enabled
    ssh-keys            = "${var.vm-os_user}:${var.vm-ssh_key}"
  }
  boot_disk {
    initialize_params {
      size     = var.vm-boot_disc_size
      type     = var.vm-boot_disc_type
      image_id = var.vm-image_id
    }
  }
  zone = var.vm-zone_id
  network_interface {
    ip_address = var.vm-private_ip_address != "" ? var.vm-private_ip_address : null
    subnet_id  = var.vm-subnet_id
    nat        = var.vm-nat_enable
  }
  resources {
    cores         = var.vm-cores
    memory        = var.vm-memory
    core_fraction = var.vm-core_fraction
  }
}

resource "null_resource" "attach_additional_disk_1" {
  count = length(var.vm-additional_disks)

  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "set -euo pipefail",
      "curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash",
      "yc compute instance attach-disk ${yandex_compute_instance.this.name} \\",
      "--disk-name ${join("-", [local.vm-hostname, "disk", count.index + 1])} \\",
      "--mode rw",
      "echo 'Finished attaching volumes'",
    ]

    connection {
      type        = "ssh"
      host        = local.nat_public_ip[0]
      user        = var.vm-os_user
      private_key = file("~/.ssh/id_rsa")
    }

  }
  # wait for disk creation
  depends_on = [
    yandex_compute_disk.disk,
  ]
}
