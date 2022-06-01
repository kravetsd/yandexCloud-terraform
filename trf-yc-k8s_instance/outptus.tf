output "control_plane_nodes" {
  value = module.k8s_instances_control_plane[*].vm-nat_public_ip
}

output "worker_nodes" {
  value = module.k8s_instances_worker_nodes[*].vm-nat_public_ip
}

output "lb" {
  value = module.k8s-lb.lb_public_ip
}