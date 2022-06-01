output "cloud-project_name" {
  description = "The name of the project to serve as a common resource name pattern"
  value       = var.cloud-project_name
}

output "vpc-id" {
  description = "The ID of the created VPC"
  value       = var.network-vpc_create ? module.vpc.vpc-id : data.yandex_vpc_network.this[0].id
}


output "vpc-subnet_ids" {
  value = var.network-vpc_create ? (length(module.subnets.subnet-ids) > 0 ? module.subnets.subnet-ids : null) : (length(module.vpc.vpc-subnet_ids) > 0 ? module.vpc.vpc-subnet_ids : null)
}

output "subnet-zone_ids" {
  value = module.subnets.availability-zones
}