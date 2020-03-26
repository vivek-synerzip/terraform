variable "vpc_cidr_block" {
	default = "10.0.0.0/16"
} 

variable "instance_tenancy" {
	default = "default"
}

variable "public_subnet_cidr_block" {
	default = "10.0.1.0/24"
}

variable "private_subnet_cidr_block" {
	default = "10.0.2.0/24"
}

variable "vpc_id" {
	default = ""
}

variable "env" {}