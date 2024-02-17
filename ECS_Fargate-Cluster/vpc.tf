resource "aws_vpc" "main" {
  cidr_block       = "172.20.0.0/16"

  tags = {
    Name = "project-vpc"
  }
}

resource "aws_subnet" "public-subnet-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "172.20.10.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"
    tags = {
        Name = "public-subnet-1a"
    }
}

resource "aws_subnet" "public-subnet-2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "172.20.11.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"
    tags = {
        Name = "publc-subnet-2"
    }
}

resource "aws_subnet" "private-subnet-1" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "172.20.20.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"
    tags = {
        Name = "private-subnet-2"
    }
}

resource "aws_subnet" "private-subnet-2" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "172.20.21.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"
    tags = {
        Name = "private-subnet-2"
    }
}
