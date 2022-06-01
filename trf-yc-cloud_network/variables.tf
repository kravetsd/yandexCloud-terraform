variable "cloud-project_name" {
  description = "Specify the name of the project as a common name pattern for resources"
  type        = string
}
variable "cloud-organization_id" {
  description = "Specify an organization ID to place a newly created cloud"
  type        = string
}

variable "additional_labels" {
  description = "Some additional labels to attach to resources in the module"
  default     = {}
}

variable "cloud-create" {
  description = "Define if cloud has to be created"
  type        = bool
  default     = false
}

variable "cloud-id" {
  description = "Specify cloud-id to place your folders and resources to."
  type        = string
  default     = ""
}

variable "cloud-folder_id" {
  description = "Specify folder-id for the chosen cloud to place your resources to."
  type        = string
}

variable "network-vpc_create" {
  description = "Define if VPC has to be created"
  type        = bool
}

variable "network-vpc_id" {
  description = "VPC ID to place your resources to"
  default     = ""
}

variable "cidr-blocks" {
  description = "CIDR blocks to place to the created network"
  type        = list(string)
  default     = []
}
variable "availability-zones" {
  description = "Availability zones to place the network to"
  type        = list(string)
  default     = []
}

variable "vpc-static_routes" {
  type    = any
  default = {}
}