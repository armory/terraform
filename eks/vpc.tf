#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

#*
resource "aws_vpc" "aws-eks" {
  cidr_block = "${var.vpc-cidr-prefix}.0.0/16"

  tags = "${
    map(
     "Name", "spin-${var.cluster-name}-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

#*
resource "aws_subnet" "aws-eks" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${var.vpc-cidr-prefix}.${count.index}.0/24"
  vpc_id            = "${aws_vpc.aws-eks.id}"

  tags = "${
    map(
     "Name", "spin-${var.cluster-name}-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

#*
resource "aws_internet_gateway" "aws-eks" {
  vpc_id = "${aws_vpc.aws-eks.id}"

  tags {
    Name = "spin-${var.cluster-name}"
  }
}

#*
resource "aws_route_table" "aws-eks" {
  vpc_id = "${aws_vpc.aws-eks.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.aws-eks.id}"
  }
}

#*
resource "aws_route_table_association" "aws-eks" {
  count = 2

  subnet_id      = "${aws_subnet.aws-eks.*.id[count.index]}"
  route_table_id = "${aws_route_table.aws-eks.id}"
}
