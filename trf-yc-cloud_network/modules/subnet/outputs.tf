output "subnet-ids" {
  value = yandex_vpc_subnet.subnets[*].id
}

output "availability-zones" {
  value = yandex_vpc_subnet.subnets[*].zone
}