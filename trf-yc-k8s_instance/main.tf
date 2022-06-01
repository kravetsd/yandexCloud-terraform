// network setup
provider "yandex" {
  alias = "root"
}

module "network" {
  source = "../trf-yc-cloud_network"

  network-vpc_create    = true
  cloud-project_name    = var.name-pattern
  cloud-organization_id = var.organization_id
  cloud-create          = false
  cloud-id              = var.cloud-id
  cloud-folder_id       = var.cloud-folder_id
  cidr-blocks           = var.cidr-blocks
  availability-zones    = var.availability-zones
  vpc-static_routes     = local.pod_network_static_routes

}

module "k8s_instances_control_plane" {
  count = var.k8s-vm_count

  providers             = { yandex = yandex.root }
  source                = "../trf-yc-vm_linux"
  vm-name               = "${var.name-pattern}-controller${count.index}"
  vm-os_user            = "ubuntu"
  vm-subnet_id          = module.network.vpc-subnet_ids[count.index]
  vm-cores              = var.vm-cores
  vm-image_id           = var.vm-image_id
  vm-memory             = var.vm-memory
  vm-ssh_key            = file(var.vm-ssh_key)
  vm-zone_id            = module.network.subnet-zone_ids[count.index]
  vm-private_ip_address = var.control_plane-private_ip_address[count.index]
  folder_id             = var.cloud-folder_id
}

module "k8s_instances_worker_nodes" {
  count = var.k8s-vm_count

  providers             = { yandex = yandex.root }
  source                = "../trf-yc-vm_linux"
  vm-name               = "${var.name-pattern}-worker${count.index}"
  vm-os_user            = "ubuntu"
  vm-subnet_id          = module.network.vpc-subnet_ids[count.index]
  vm-cores              = var.vm-cores
  vm-image_id           = var.vm-image_id
  vm-memory             = var.vm-memory
  vm-ssh_key            = file(var.vm-ssh_key)
  vm-zone_id            = module.network.subnet-zone_ids[count.index]
  vm-private_ip_address = var.worker_node-private_ip_address[count.index]
  folder_id             = var.cloud-folder_id
}

module "k8s-lb" {
  source = "../trf-yc-nlb"

  providers     = { yandex = yandex.root }
  nlb-create    = true
  nlb-region    = "ru-central1"
  nlb-folder_id = var.cloud-folder_id
  nlb-listeners = {
    control_plane = {
      name        = "controlplane"
      port        = 6443
      target_port = 6443
    },
    ssh = {
      name        = "ssh"
      port        = 22
      target_port = 22
    }
  }
  nlb-target_group = {
    healthcheck-name      = "healthz"
    healthcheck_http_port = "80"
    healthcheck_http_path = "/healthz"
    name                  = "healthz-tg"
    targets = [
      {
        name      = "cp_node_0"
        subnet_id = module.k8s_instances_control_plane[0].subnet_id
        address   = module.k8s_instances_control_plane[0].vm-private_ip[0]
      },
      {
        name      = "cp_node_1"
        subnet_id = module.k8s_instances_control_plane[1].subnet_id
        address   = module.k8s_instances_control_plane[1].vm-private_ip[0]
        }, {
        name      = "cp_node_2"
        subnet_id = module.k8s_instances_control_plane[2].subnet_id
        address   = module.k8s_instances_control_plane[2].vm-private_ip[0]
      },
    ]
  }
  nlb-name = var.name-pattern

}

locals {
// TODO: pod network and routing must be unified and refactored with no hardcode
  pod_network_static_routes = [
    {
      next_hop_address   = module.k8s_instances_worker_nodes[0].vm-private_ip[0]
      destination_prefix = "10.200.0.0/24"
    },
    {
      next_hop_address   = module.k8s_instances_worker_nodes[1].vm-private_ip[0]
      destination_prefix = "10.200.1.0/24"
    },
    {
      next_hop_address   = module.k8s_instances_worker_nodes[2].vm-private_ip[0]
      destination_prefix = "10.200.2.0/24"
    },
  ]
}
