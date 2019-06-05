
resource "aws_lb" "spin_nlb" {
  name                             = "${var.nlb-name}"
  internal                         = "true"
  load_balancer_type               = "network"
  subnets                          = ["${data.aws_subnet_ids.eks_subnets.ids}"]
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = false
  ip_address_type                  = "ipv4"

  tags = "${
    map(
     "kubernetes.io/service-name", "${var.cluster-name}/${var.nlb-name}",
     "kubernetes.io/cluster/${var.cluster-name}", "owned"
    )
  }"
}

resource "aws_lb_target_group" "spin_tg" {
  name        = "k8s-tg-gate-443-${var.target-port}"
  port        = "${var.target-port}"
  protocol    = "TCP"
  vpc_id      = "${data.aws_vpc.eks_vpc.id}"
  target_type = "instance"

  tags = "${
    map(
     "kubernetes.io/service-name", "${var.cluster-name}/${var.nlb-name}",
     "kubernetes.io/cluster/${var.cluster-name}", "owned"
    )
  }"
}

resource "aws_lb_target_group_attachment" "spin_tg_instances" {
  count            = "${length(data.aws_instances.eks-nodes.ids)}"
  target_group_arn = "${aws_lb_target_group.spin_tg.arn}"
  target_id        = "${data.aws_instances.eks-nodes.ids[count.index]}"
  port             = "${var.target-port}"
}

resource "aws_lb_listener" "spin_nlb_listener" {
  load_balancer_arn = "${aws_lb.spin_nlb.arn}"
  port              = "443"
  protocol          = "TLS"

  certificate_arn = "${data.aws_acm_certificate.spin_cert.arn}"
  ssl_policy      = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.spin_tg.arn}"
  }
}

resource "aws_security_group_rule" "spin_sg_allow_comm" {
  description = "kubernetes.io/rule/nlb/client=${var.nlb-name}"
  type        = "ingress"
  from_port   = "${var.target-port}"
  to_port     = "${var.target-port}"
  protocol    = "TCP"

  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${data.aws_security_group.eks_sg_nodes.id}"
}

resource "aws_security_group_rule" "spin_sg_allow_health" {
  description = "kubernetes.io/rule/nlb/health=${var.nlb-name}"
  type        = "ingress"
  from_port   = "${var.target-port}"
  to_port     = "${var.target-port}"
  protocol    = "TCP"

  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = "${data.aws_security_group.eks_sg_nodes.id}"
}
