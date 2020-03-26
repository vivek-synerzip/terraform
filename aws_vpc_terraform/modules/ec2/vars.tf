variable "ami_id" {
	default = "ami-07ebfd5b3428b6f4d"
}

variable "instance_type" {
	default = "t2.micro"
}

variable "instance_count" {
	default = 1
}

variable "key_name" {
	default = "Own-Ubuntu-key"
}

variable "web_security_group" {
	default = ""
}

variable "db_security_group" {
	default = ""
}

variable "public_subnet_id" {
	default = ""
}

variable "private_subnet_id" {
	default = ""
}

variable "vpc_security_group_ids" {}
