resource "aws_instance" "public_instance" {
  count         = "${var.public_instance_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id     = "${var.public_subnet_id}"
  vpc_security_group_ids = ["${var.web_security_group}"]
  
  tags = {
    Name  = "Terraform-Public-Instance-${count.index + 1}"
  }
  depends_on = ["var.vpc_id","var.public_subnet_id","var.web_security_group"]
}

resource "aws_instance" "private_instance" {
  count         = "${var.private_instance_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  subnet_id     = "${var.private_subnet_id}"
  vpc_security_group_ids = ["${var.db_security_group}"]

  tags = {
    Name  = "Terraform-Private-Instance-${count.index + 1}"
  }
  depends_on = ["var.vpc_id","var.private_subnet_id","var.db_security_group",var.public_subnet_id]
}

