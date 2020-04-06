resource "aws_instance" "example" {
	ami = "${var.AMI_ID}"
	instance_type = "t2.micro"
	
	#The VPC subnet
	subnet_id = "${aws_subnet.main-public-1.id}"

	# the security group
	vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

	# the public SSH key 
	key_name = "${aws_key_pair.mykey.key_name}"
}