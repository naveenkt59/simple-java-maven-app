resource "aws_security_group" "sg-opa-apijobs" {
  count       = "${local.security_group_count}"
  name        = "java_sg"
  vpc_id      = "vpc-0a2edf818fae870ca"
  description = "OPA - API Jobs - Instance security group"
#  tags        = "${module.label.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "egress" {
  count             = "${var.create_default_security_group == "true" ? 1 : 0}"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg-opa-apijobs.id}"
}

resource "aws_security_group_rule" "ingress" {
  count             = "${var.create_default_security_group == "true" ? length(compact(var.allowed_ports)) : 0}"
  type              = "ingress"
  from_port         = "${element(var.allowed_ports, count.index)}"
  to_port           = "${element(var.allowed_ports, count.index)}"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.sg-opa-apijobs.id}"
}