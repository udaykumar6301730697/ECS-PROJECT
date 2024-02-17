resource "aws_security_group" "main-ext-alb-sg" {
  vpc_id = "${aws_vpc.main.id}"
  name = "main-ext-alb-sg"
  description = "Application load balancer instance access"
  egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

  ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

  tags = {
    Name = "main-ext-alb-sg"
  }
}

resource "aws_security_group" "main-int-service-sg" {
  vpc_id = "${aws_vpc.main.id}"
  name = "main-int-service-sg"
  description = "Application load balancer instance access"
  tags = {
    Name = "main-int-service-sg"
  }
}


resource "aws_security_group_rule" "main-int-service-sg-ingress" {
  type = "ingress"
  from_port = 0
  to_port = 65535
  protocol = "tcp"
  security_group_id = aws_security_group.main-int-service-sg.id
  source_security_group_id = aws_security_group.main-ext-alb-sg.id
  description = "Accept traffic from ALB"
}

resource "aws_security_group_rule" "main-int-service-sg-egress" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.main-int-service-sg.id
}
