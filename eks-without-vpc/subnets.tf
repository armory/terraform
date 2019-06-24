#
#  * Subnets
#  * Route Table
#

<<<<<<< HEAD
resource "aws_subnet" "aws-eks" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "${var.vpc-cidr-prefix}.${count.index + var.subnet-3rd-octet}.0/24"
=======
resource "aws_subnet" "aws-eks-subnet-1" {
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  cidr_block        = "${var.subnet-1-cidr}"
  vpc_id            = "${var.vpc-id}"

  tags = "${
    map(
     "Name", "${var.cluster-name}-subnet-1",
     "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "aws-eks-subnet-2" {
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  cidr_block        = "${var.subnet-2-cidr}"
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
  vpc_id            = "${var.vpc-id}"

  tags = "${
    map(
<<<<<<< HEAD
     "Name", "reltio-${var.cluster-name}-node",
=======
     "Name", "${var.cluster-name}-subnet-2",
>>>>>>> 67192546e927e3218dd143d43da29b6166495711
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

<<<<<<< HEAD
resource "aws_route_table_association" "aws-eks" {
  count = 2

  subnet_id      = "${aws_subnet.aws-eks.*.id[count.index]}"
  route_table_id = "${aws_route_table.aws-eks.id}"
}
=======
resource "aws_route_table_association" "aws-eks-subnet-1" {
  subnet_id      = "${aws_subnet.aws-eks-subnet-1.id}"
  route_table_id = "${aws_route_table.aws-eks.id}"
}

resource "aws_route_table_association" "aws-eks-subnet-2" {
  subnet_id      = "${aws_subnet.aws-eks-subnet-2.id}"
  route_table_id = "${aws_route_table.aws-eks.id}"
}

>>>>>>> 67192546e927e3218dd143d43da29b6166495711
