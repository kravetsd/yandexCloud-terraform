variable "name-pattern" {
  description = "the name pattern to add to each component name"
  type        = string
}
variable "organization_id" {
  description = "The id of the current organization"
  type        = string
}
variable "cloud-id" {
  description = "Cloud ID to deploy the component to"
  type        = string
}

variable "vm-ssh_key" {
  description = "public key for accessing via ssh for os user"
}

variable "k8s-vm_count" {
  description = "A number of instances to create"
  default     = 3
}

variable "vm-cores" {
  description = "A number of CPU cores for VM"
  default     = 2
}

variable "vm-image_id" {
  description = "Image od to use for VM"
}

variable "vm-memory" {
  description = "VM memory specification"
  default     = 4
}

variable "cloud-folder_id" {
  description = "Folder ID to set up VMs"
}

variable "cidr-blocks" {
  description = "The list of cidr blocks"
  type        = list(string)

}
variable "availability-zones" {
  description = "The availability zone of the VPC to place the subnet"
  type        = list(string)
}


variable "vm-zone_ids" {
  description = "VM zone ID"
  type        = list(string)
}

variable "control_plane-private_ip_address" {
  description = "A list of ip address to assign to control plane nodes"
  default     = []
}

variable "worker_node-private_ip_address" {
  description = "A list of ip addresses to assign to worker nodes"
  default     = []
}