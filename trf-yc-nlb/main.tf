resource "yandex_lb_target_group" "this" {
  count = var.nlb-create ? 1 : 0

  name      = var.nlb-target_group["name"]
  region_id = var.nlb-region
  folder_id = var.nlb-folder_id
  labels = merge({
    resource-type = "nlb" },
    var.nlb-labels
  )

  dynamic "target" {
    for_each = var.nlb-create ? { for target in flatten([for k, v in var.nlb-target_group : v if k == "targets"]) : target.name => target } : {}
    content {
      subnet_id = target.value["subnet_id"]
      address   = target.value["address"]
    }
  }

}


resource "yandex_lb_network_load_balancer" "this" {
  name = replace("${var.nlb-name}-nlb", "_", "-")

  dynamic "listener" {

    for_each = var.nlb-create ? var.nlb-listeners : {}

    content {
      name        = listener.value["name"]
      port        = listener.value["port"]
      target_port = listener.value["target_port"]
      external_address_spec {
        ip_version = "ipv4"
      }
    }
  }
  folder_id = var.nlb-folder_id
  attached_target_group {
    target_group_id = yandex_lb_target_group.this[0].id
    healthcheck {
      name = var.nlb-target_group["healthcheck-name"]
      http_options {
        port = var.nlb-target_group["healthcheck_http_port"]
        path = var.nlb-target_group["healthcheck_http_path"]
      }
    }
  }
}
