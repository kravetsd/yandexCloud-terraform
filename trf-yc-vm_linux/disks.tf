resource "yandex_compute_disk" "disk" {
  count = length(var.vm-additional_disks)

  name = "${local.vm-hostname}-disk-${count.index + 1}"
  type = var.vm-additional_disks[count.index]["type"]
  zone = yandex_compute_instance.this.zone
  size = var.vm-additional_disks[count.index]["size"]

  image_id    = lookup(var.vm-additional_disks[count.index], "image_id", null)
  snapshot_id = lookup(var.vm-additional_disks[count.index], "snapshot_id", null)
}

//TODO: provide additional requirements and write a script allowing to automatically mount all additional disks to the VM.