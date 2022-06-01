// TODO: extract exact public ip address from lb output
output "lb_public_ip" {
  value = yandex_lb_network_load_balancer.this
}