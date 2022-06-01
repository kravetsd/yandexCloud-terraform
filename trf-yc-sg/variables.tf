variable "sg-ingress_rules" {
  description = "A list of ingress rules"
  default     = []
  type        = list(any)
}
variable "sg-egress_rules" {
  description = "A list of egress rules"
  type        = list(any)
  default = [
    {
      #      from_port     = "-1"
      #      to_port       = "-1"
      protocol      = "ANY"
      v4_cidr_block = "0.0.0.0/0"
      description   = "Default outbound rule"
    },
  ]
}
variable "sg-create" {
  description = "Specify if SG has to be created"
  type        = bool
  default     = true
}
variable "sg-name" {
  description = "The name of security group"
  type        = string
  default     = ""
}
variable "sg-description" {
  type        = string
  description = "Description of security group"
  default     = ""
}
variable "sg-vpc_id" {
  description = "Specify VPC id to place the created security group to"
  type        = string
  default     = ""
}
variable "sg-labels" {
  description = "A map of labels to assign to the resources created"
  type        = map(string)
  default     = {}
}
