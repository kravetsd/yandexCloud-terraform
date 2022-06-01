variable "vm-cores" {
  description = "CPU cores for the instance."
  type        = number
}

variable "vm-memory" {
  description = "Memory size in GB."
  type        = number
}

variable "vm-image_id" {
  description = "Image ID to use for bootstrapping the VM"
  type        = string
}

variable "vm-boot_disc_size" {
  description = "Size of the disk in GB."
  type        = number
  default     = 20
}
variable "vm-boot_disc_type" {
  description = "Boot disk type"
  type        = string
  default     = "network-hdd"
}

variable "vm-ssh_key" {
  description = "Public ssh key for connecting to machine"
  type        = string
}

variable "vm-subnet_id" {
  description = "Subnet id to place the instance to"
  type        = string
}

variable "vm-name" {
  description = "VM name"
  type        = string
}

variable "vm-hostname" {
  description = "VM hostname can be set via this variable"
  type        = string
  default     = ""
}

variable "vm-nat_enable" {
  description = "Specify if NAT has to be enabled to automatically assign a public ip address"
  type        = bool
  default     = true
}

variable "vm-serial_port_enabled" {
  description = "Specify if serial port has to be enabled"
  type        = bool
  default     = true
}

variable "vm-os_user" {
  description = "Specify a user for VM. Must to correlate to vm-ssh_keys parameter"
}

variable "additional_labels" {
  description = "Some additional labels to attach to resources in the module"
  default     = {}
}

variable "vm-platform_id" {
  description = "Which pgysical processor to use."
  default     = "standard-v2"
}

variable "vm-core_fraction" {
  description = "Specifies baseline performance for a core as a percent."
  type        = number
  default     = 100
}

variable "vm-additional_disks" {
  description = "A number of additional disks to attache to the instance."
  type        = list(map(any))
  default     = []
}

variable "vm-zone_id" {
  description = "VM zone ID"
}

variable "vm-private_ip_address" {
  description = "The private IP address to assign to the instance."
  default     = ""
}

variable "folder_id" {
  description = "Folder id to place instance to"
}