#
#  * Subnets
#  * Route Table
#

resource "aws_subnet" "aws-eks" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${var.vpc-cidr-prefix}.${count.index + var.subnet-3rd-octet}.0/24"
  vpc_id            = "${var.vpc-id}"

  tags = "${
    map(
     "Name", "reltio-${var.cluster-name}-node",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_route_table" "aws-eks" {
  vpc_id = "${var.vpc-id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.igateway-id}"
  }
}

resource "aws_route_table_association" "aws-eks" {
  count = 2

  subnet_id      = "${aws_subnet.aws-eks.*.id[count.index]}"
  route_table_id = "${aws_route_table.aws-eks.id}"
}
