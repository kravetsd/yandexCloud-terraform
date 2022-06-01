resource "yandex_vpc_subnet" "subnets" {
  count          = var.subnet-create && length(var.cidr-blocks) > 0 ? length(var.cidr-blocks) : 0
  v4_cidr_blocks = [element(var.cidr-blocks, count.index)]
  zone           = element(var.availability-zones, count.index)
  network_id     = var.vpc-id
  labels         = var.labels
  folder_id      = var.folder_id
  // TODO: design route table linking with subnets
#  route_table_id = var.route-table
}
