variable "nlb-create" {
  default = true
}
variable "nlb-target_group" {
  type    = any
  default = {}
}
variable "nlb-region" {
  default = ""
}
variable "nlb-folder_id" {
  default = ""
}
variable "nlb-labels" {
  default = {}
}
variable "nlb-listeners" {
  type    = map(map(string))
  default = {}
}
variable "nlb-name" {
  default = ""
}

