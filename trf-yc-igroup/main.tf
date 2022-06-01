resource "yandex_compute_instance_group" "this" {
  name                = replace("${var.igroup-name}-igroup", "_", "-")
  folder_id           = var.igroup-folder_id
  service_account_id  = yandex_iam_service_account.this.id
  deletion_protection = var.igroup-deletion_protection
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = var.igroup-resources_memory
      cores  = var.igroup-resources_cores
    }
    boot_disk { //TODO: improve additional disks attachment.
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.igroup-image_id
        size     = var.igroup-disk_size
      }
    }
    network_interface {
      network_id = var.igroup-vpc_id
      subnet_ids = var.igroup-subnet_ids
    }
    labels = merge({
      resource-type = "instance-group" },
      var.igroup-labels
    )
    metadata = {
      ssh-keys = "ubuntu:${file(var.igroup-ssh_key_file)}"
    }
    network_settings {
      type = "STANDARD"
    }
  }
  // TODO: cloud init script for VMs has to be integrated.
  variables = {
    test_key1 = "test_value1"
    test_key2 = "test_value2"
  }

  scale_policy {
    // TODO: add fixzed scale policy support
    auto_scale {
      initial_size           = 1
      measurement_duration   = 200
      max_size               = var.igroup-autoscale_max
      cpu_utilization_target = var.igroup-cpu_utilization_target

    }
  }

  allocation_policy {
    zones = var.igroup-allocation_policy
  }

  deploy_policy {
    max_unavailable = var.igroup-max_unavlilable != null ? var.igroup-max_unavlilable : var.igroup-fixed_scale_size
    max_creating    = var.igroup-max_creating != null ? var.igroup-max_creating : var.igroup-fixed_scale_size
    max_expansion   = var.igroup-max_expansion != null ? var.igroup-max_expansion : var.igroup-fixed_scale_size
    max_deleting    = var.igroup-max_deleting != null ? var.igroup-max_deleting : var.igroup-fixed_scale_size
  }
  depends_on = [yandex_resourcemanager_folder_iam_member.compute_admin, yandex_resourcemanager_folder_iam_member.vpc_user]
}

resource "yandex_iam_service_account" "this" {
  name        = replace("${var.igroup-name}-sa", "_", "-")
  description = "service account to manage VMs"
  folder_id   = var.igroup-folder_id
}

data "yandex_resourcemanager_cloud" "current_cloud" {
  name = var.igroup-cloud_name
}

resource "yandex_resourcemanager_folder_iam_member" "vpc_user" {
  folder_id = var.igroup-folder_id

  role   = "vpc.user"
  member = "serviceAccount:${yandex_iam_service_account.this.id}"

}

resource "yandex_resourcemanager_folder_iam_member" "compute_admin" {
  folder_id = var.igroup-folder_id

  role   = "compute.admin"
  member = "serviceAccount:${yandex_iam_service_account.this.id}"

}