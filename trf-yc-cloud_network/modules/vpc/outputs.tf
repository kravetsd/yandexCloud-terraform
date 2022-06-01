output "vpc-id" {
  description = "Id of the created VPC"
  value       = length(yandex_vpc_network.this[*]) > 0 ? yandex_vpc_network.this[0].id : null
}

output "vpc-subnet_ids" {
  value = length(yandex_vpc_network.this[*]) > 0 ? yandex_vpc_network.this[0].subnet_ids : null
}