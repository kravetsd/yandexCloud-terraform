variable "cidr-blocks" {
  description = "The list of cidr blocks"
  type        = list(string)

}
variable "availability-zones" {
  description = "The availability zone of the VPC to place the subnet"
  type        = list(string)

}
variable "vpc-id" {
  description = "The ID of the VPC to plcae the subnet"
  type        = string
}

variable "subnet-create" {
  description = "Define if subnet has to be created."
  type        = bool
  default     = true
}

variable "labels" {
  description = "Additional labels to assign to the resource"
  type        = map
  default     = {}
}

variable "folder_id" {
  type = string
  description = "folder id to place the subnet to"
}
#
#variable "route-table" {
#  description = "Route table ID to attach to the subnet created"
#  type = string
#}