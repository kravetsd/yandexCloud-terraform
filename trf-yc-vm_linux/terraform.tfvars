vm-cores     = 2
vm-memory    = 4
vm-subnet_id = "example2-subnet-id"
vm-name      = "kravetsd-vm1"
vm-image_id  = "fd82re2tpfl4chaupeuf" //ubuntu 20.04
vm-ssh_key   = "ssh-rsa example ssh publick key"
vm-os_user   = "ubuntu"

vm-core_fraction = 5
vm-additional_disks = [
  {
    size = "15",
    type = "network-ssd"
    //TODO: device_name = "/dev/xvdb",
    //TODO: mount_point = "/apps"
  }
]