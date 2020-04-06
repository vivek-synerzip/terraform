 variable "AWS_ACCESS_KEY" {}

 variable "AWS_SECRET_KEY" {}

 variable "AWS_REGION" {
 	default = "us-east-1"
 }

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}

variable "ECS_AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-07b0b76533a8c9b01"
  }
}