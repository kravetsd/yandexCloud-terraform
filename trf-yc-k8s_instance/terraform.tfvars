vm-ssh_key                       = "~/.ssh/id_rsa.pub"
vm-image_id                      = "fd82re2tpfl4chaupeuf"
name-pattern                     = "k8s-node"
availability-zones               = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
cidr-blocks                      = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
vm-zone_ids                      = []
control_plane-private_ip_address = ["10.10.1.8", "10.10.2.8", "10.10.3.8"]
worker_node-private_ip_address   = ["10.10.1.18", "10.10.2.18", "10.10.3.18"]
