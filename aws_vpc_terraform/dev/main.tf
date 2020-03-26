module "terraform_vpc" {
	source = "../modules/vpc"
	vpc_cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	env = "${var.env}"	
}

module "public_subnet" {
	source = "../modules/vpc"
	vpc_id = "${module.terraform_vpc.vpc_id}"
	public_subnet_cidr_block = "10.0.1.0/24"
	env = "${var.env}"
}

module "private_subnet" {
	source = "../modules/vpc"
	vpc_id = "${module.terraform_vpc.vpc_id}"
	private_subnet_cidr_block = "10.0.2.0/24"
	env = "${var.env}"
}

module "sg" {
	source = "../modules/sg"
	vpc_id = "${module.terraform_vpc.vpc_id}"
}

module "ec2_public" {
	source = "../modules/ec2"
	instance_count = 1
	ami_id = "ami-07ebfd5b3428b6f4d"
	instance_type = "t2.micro"
	key_name = "Own-Ubuntu-key"
	public_subnet_id = "${module.terraform_vpc.vpc_public_subnet_id}"
	vpc_security_group_ids = ["${module.sg.WebSecurityGroup}"]
}

module "ec2_private" {
	source = "../modules/ec2"
	instance_count = 1
	ami_id = "ami-07ebfd5b3428b6f4d"
	instance_type = "t2.micro"
	key_name = "Own-Ubuntu-key"
	private_subnet_id = "${module.terraform_vpc.vpc_private_subnet_id}"
	vpc_security_group_ids = ["${module.sg.DBSecurityGroup}"]
}



