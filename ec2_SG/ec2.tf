resource "aws_instance" "example" {
  ami           = "ami-07ebfd5b3428b6f4d"
  instance_type = "t2.micro"
  key_name = "Own-Ubuntu-key"
  security_groups = ["${aws_security_group.allow_rdp.name}"]

}