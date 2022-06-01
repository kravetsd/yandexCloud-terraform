resource "yandex_vpc_network" "this" {
  count = var.vpc-create ? 1 : 0

  name        = var.vpc-name
  description = var.vpc-description
  folder_id   = var.vpc-folder_id
  labels      = var.vpc-labels
}