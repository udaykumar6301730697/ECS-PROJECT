resource "aws_internet_gateway" "main-igw" {
    vpc_id = "${aws_vpc.main.id}"
    tags = {
        Name = "internet-gateway"
    }
}

resource "aws_route_table" "public-subnet-rt" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0"
        //Route table uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.main-igw.id}"
    }

    tags = {
        Name = "public-subnet-rt"
    }
}

resource "aws_route_table_association" "RT-public-subnet-1-associate"{
    subnet_id = "${aws_subnet.public-subnet-1.id}"
    route_table_id = "${aws_route_table.public-subnet-rt.id}"
}

resource "aws_route_table_association" "RT-public-subnet-2-associate"{
    subnet_id = "${aws_subnet.public-subnet-2.id}"
    route_table_id = "${aws_route_table.public-subnet-rt.id}"
}

# Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "Nat-Gateway-EIP" {
  vpc = true
}

# Creating a NAT Gateway!
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  subnet_id = "${aws_subnet.public-subnet-1.id}"
  tags = {
    Name = "nat-gateway"
  }
}

# Creating a Route Table for the Nat Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }
  tags = {
    Name = "nat-gatewat-rt"
  }
}

resource "aws_route_table_association" "Nat-Gateway-RT-Association-1" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]
  subnet_id      = "${aws_subnet.private-subnet-1.id}"
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

resource "aws_route_table_association" "Nat-Gateway-RT-Association-2" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]
  subnet_id      = "${aws_subnet.private-subnet-2.id}"
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}
