variable "igroup-name" {
  type = string
}
variable "igroup-folder_id" {
  type = string
}

variable "igroup-deletion_protection" {
  type    = bool
  default = true
}
variable "igroup-image_id" {
  type = string
}
variable "igroup-disk_size" {
  type    = number
  default = 10
}
variable "igroup-vpc_id" {
  type = string
}
variable "igroup-subnet_ids" {
  default = []
}
variable "igroup-labels" {
  default = {}
}

variable "igroup-allocation_policy" {
  default = ["ru-central1-a"]
}

variable "igroup-cloud_name" {
  type = string
}

variable "igroup-resources_memory" {
  default = 3
}
variable "igroup-resources_cores" {
  default = 3
}

variable "igroup-ssh_key_file" {
  type = string
}
variable "igroup-fixed_scale_size" {
  type = number
}

variable "igroup-max_unavlilable" {
  type    = number
  default = null
}

variable "igroup-max_creating" {
  type    = number
  default = null
}

variable "igroup-max_expansion" {
  type    = number
  default = null
}

variable "igroup-max_deleting" {
  type    = number
  default = null
}

variable "igroup-autoscale_max" {
  type = number
}
variable "igroup-cpu_utilization_target" {
  default = 90
}