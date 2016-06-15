variable "region"  { default = "us-east-1" }
variable "name" {
  default = "public"
}
variable "cidrs" {
}
variable "azs" {
}
variable "vpc_id" {
}
variable "igw_id" {
}
variable "map_public_ip_on_launch" {
  default = true
}

provider "aws" {
  alias  = "local"
  region = "${var.region}"
}

resource "aws_subnet" "public" {
  provider = "aws.local"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${element(split(",", var.cidrs), count.index)}"
  availability_zone       = "${element(split(",", var.azs), count.index)}"
  count                   = "${length(split(",", var.cidrs))}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name = "${var.name}.${element(split(",", var.azs), count.index)}"
  }
}

resource "aws_route_table" "public" {
  provider = "aws.local"
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.igw_id}"
  }

  tags {
    Name = "${var.name}.${element(split(",", var.azs), count.index)}"
  }
}

resource "aws_route_table_association" "public" {
  provider = "aws.local"
  count          = "${length(split(",", var.cidrs))}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

output "subnet_ids" {
  value = "${join(",", aws_subnet.public.*.id)}"
}
