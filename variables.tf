variable "aws_region" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "us-east-1a_availability_zone" {
  type = string
}
variable "us-east-1c_availability_zone" {
  type = string
}
variable "us-east-1e_availability_zone" {
  type = string
}
variable "public_subnet_1_cidr" {
  type = string
}
variable "public_subnet_2_cidr" {
  type = string
}
variable "public_subnet_3_cidr" {
  type = string
}
variable "private_subnet_1_cidr" {
  type = string
}
variable "private_subnet_2_cidr" {
  type = string
}
variable "private_subnet_3_cidr" {
  type = string
}
variable "public_subnet_1_name" {
  type = string
}
variable "public_subnet_2_name" {
  type = string
}
variable "public_subnet_3_name" {
  type = string
}
variable "private_subnet_1_name" {
  type = string
}
variable "private_subnet_2_name" {
  type = string
}
variable "private_subnet_3_name" {
  type = string
}

#############################################
###### Variables for EKS Managed Node Group
variable "min_size" {
  type        = number
  description = "Minimum size of the node group"
}

variable "max_size" {
  type        = number
  description = "Maximum size of the node group"
}

variable "desired_size" {
  type        = number
  description = "Desired size of the node group"
}

variable "instance_types" {
  type        = list(string)
  description = "Instance types for the node group"
}

variable "ami_type" {
  type        = string
  description = "AMI type for the node group instances"
}

variable "disk_size" {
  type        = number
  description = "Disk size (in GB) for the node group instances"
}

variable "max_unavailable" {
  type        = number
  description = "Maximum number of unavailable nodes during updates"
}