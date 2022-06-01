provider "yandex" {}

locals {
}

data "yandex_resourcemanager_cloud" "this" {
  count    = var.cloud-create ? 0 : 1
  cloud_id = var.cloud-id
}

data "yandex_resourcemanager_folder" "this" {
  count     = var.cloud-create ? 0 : 1
  folder_id = var.cloud-folder_id
}

data "yandex_vpc_network" "this" {
  count      = var.network-vpc_create ? 0 : 1
  network_id = var.network-vpc_id
}

resource "yandex_resourcemanager_cloud" "this" {
  count           = var.cloud-create ? 1 : 0
  organization_id = var.cloud-organization_id
  description     = "Managed by terraform"
  name            = "${var.cloud-project_name}-cloud"

  labels = merge(var.additional_labels, {
    resource_type = "organization_cloud"
  })
}

resource "yandex_resourcemanager_folder" "this" {
  count       = var.cloud-create ? 1 : 0
  description = "Managed by terraform"
  cloud_id    = yandex_resourcemanager_cloud.this[0].id
  name        = "${var.cloud-project_name}-folder"

  labels = merge(var.additional_labels, {
    resource_type = "cloud_folder"
  })
}

module "vpc" {
  source = "./modules/vpc"

  vpc-create    = var.network-vpc_create
  vpc-folder_id = var.cloud-create ? yandex_resourcemanager_folder.this[0].id : data.yandex_resourcemanager_folder.this[0].id
  vpc-name      = "${var.cloud-project_name}-vpc"
  vpc-labels = merge(var.additional_labels, {
    resource_type = "network_vpc"
  })

}

module "subnets" {
  source = "./modules/subnet"

  subnet-create      = var.network-vpc_create
  cidr-blocks        = var.cidr-blocks
  availability-zones = var.availability-zones
  vpc-id             = var.network-vpc_create ? module.vpc.vpc-id : var.network-vpc_id
  folder_id          = var.cloud-folder_id
}

resource "yandex_vpc_route_table" "this" {
  folder_id  = var.cloud-create ? yandex_resourcemanager_folder.this[0].id : data.yandex_resourcemanager_folder.this[0].id
  count      = var.network-vpc_create ? 1 : 0
  name       = "${var.cloud-project_name}-rt"
  network_id = module.vpc.vpc-id

  dynamic "static_route" {
    for_each = { for route in var.vpc-static_routes : route.next_hop_address => route.destination_prefix }
    content {
      destination_prefix = static_route.value
      next_hop_address   = static_route.key
    }
  }
}