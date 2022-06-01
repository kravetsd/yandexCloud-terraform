output "sg-id" {
  description = "Id of the created VPC"
  value       = length(yandex_vpc_security_group.this[*]) > 0 ? yandex_vpc_security_group.this[0].id : null
}
output "sg-name" {
  value = length(yandex_vpc_security_group.this[*]) > 0 ? yandex_vpc_security_group.this[0].name : null
}