variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy the Velo Edge"
}

variable "private_subnet_id" {
  type        = string
  description = "Private subnet ID for the LAN interface"
}

variable "public_subnet_id" {
  type        = string
  description = "Public subnet ID for the WAN interface"
}

variable "name" {
  type        = string
  description = "Instance name"
}

variable "instance_size" {
  type        = string
  description = "Instance size"
  default     = "c4.large"
}

variable "ssh_key" {
  type        = string
  description = "SSH key for the ubuntu VMs"
}