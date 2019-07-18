# NAT Instance

resource "aws_security_group" "nat"{
  name = "sg_test_web"
  description = "Allow traffic from public subnet"

  ingress {
    from_port = "${var.ingress_from_port}"
    to_port = "${var.ingress_to_port}"
    protocol = "tcp"
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.public_subnet_cidr}"]
  }

  vpc_id = "${var.vpc_id}"

  tags {
    Name = "NATSG"
  }
}

resource "aws_instance" "nat" {
    ami = "${var.ami-nat}" # this is a special ami preconfigured to do NAT
    availability_zone = "${var.availability_zone}"
    instance_type = "m1.small"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${var.public_subnet_id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "VPC NAT"
    }
}

resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
}

# Define the private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.private_subnet_cidr}"
  availability_zone = "${var.availability_zone}"

  tags {
    Name = "private-subnet"
  }
}

resource "aws_route_table" "aws-route_private" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table_association" "aws-route-a-private" {
  subnet_id      = "${aws_subnet.private-subnet.id}"
  route_table_id = "${aws_route_table.aws-route_private.id}"
}