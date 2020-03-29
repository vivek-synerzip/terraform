#####################################
# Creating VPC with two subnets 
#####################################

resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr_block}"
  instance_tenancy = "${var.instance_tenancy}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"

  tags = {
    Name = "${var.env}_vpc"
    Env  = "${var.env}"
  }
}


#####################################
# Creating public subnet
#####################################

resource "aws_subnet" "public_subnet" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.public_subnet_cidr_block}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.env}_public_subnet"
    Env  = "${var.env}"
  }
  depends_on = ["aws_vpc.main"]
}


#####################################
# Creating private subnet
#####################################

resource "aws_subnet" "private_subnet" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.private_subnet_cidr_block}"
  availability_zone = "us-east-1a"
  tags = {
    Name = "${var.env}_private_subnet"
    Env  = "${var.env}"
  }
  depends_on = ["aws_vpc.main"]
}

#####################################
# Creating Internet Gateway
#####################################

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "${var.env}_gw"
    Env  = "${var.env}"
  }
  depends_on = ["aws_vpc.main"]
}


#####################################
# Creating Default Route Table
#####################################

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  
  tags = {
    Name = "Public Route Table"
    env  = "${var.env}"
  }
  depends_on = ["aws_vpc.main","aws_internet_gateway.gw"]
}


##############################################
# Route table association with public subnets
##############################################

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
  depends_on = ["aws_vpc.main","aws_internet_gateway.gw","aws_route_table.public_route_table"]
}

