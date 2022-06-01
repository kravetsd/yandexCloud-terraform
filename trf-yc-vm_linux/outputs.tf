output "vm-nat_public_ip" {
  description = "Public IP address assigned automatically"
  value       = local.nat_public_ip[*]
}

output "vm-private_ip" {
  description = "Private IP address assigned to instance"
  value       = local.private_ip
}

output "vm-login_to_serial_console" {
  value = "ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/id_rsa ${yandex_compute_instance.this.id}.${var.vm-os_user}@serialssh.cloud.yandex.net"
}

output "vm-ssh_login" {
  value = "ssh -i ~/.ssh/id_rsa ${var.vm-os_user}@${local.nat_public_ip[0]}"
}

output "subnet_id" {
  description = "Subnet ID where the instance was placed"
  value       = var.vm-subnet_id
}