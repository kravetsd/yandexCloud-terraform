variable "vpc-name" {
  description = "The name of the VPC to create"
  type        = string
}

variable "vpc-folder_id" {
  type        = string
  description = "The ID of the folder to place the resource"
}

variable "vpc-labels" {
  description = "Additional labels to assign to the resource"
  type        = map
  default     = {}
}

variable "vpc-create" {
  description = "Define if VPC has to be created."
  type        = bool
}

variable "vpc-description" {
  description = "VPC description"
  type = string
  default = "Managed by terraform"
}