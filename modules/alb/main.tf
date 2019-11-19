resource "aws_lb" "alb" {
  name               = "${var.name_prefix}-alb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.subnet_ids
  tags               = var.tags
}

resource "aws_lb_listener" "lb-listener-http" {
  count             = length(var.http_ports)
  load_balancer_arn = aws_lb.alb.arn
  port              = var.http_ports[count.index][0]
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg-http[count.index].arn
  }
}

resource "aws_lb_target_group" "lb-tg-http" {
  count    = length(var.http_ports)
  name     = "${var.name_prefix}-tg-http-${count.index}"
  port     = var.http_ports[count.index][1]
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags     = var.tags
}

resource "aws_lb_listener" "lb-listener-https" {
  count             = length(var.https_ports_certs)
  load_balancer_arn = aws_lb.alb.arn
  port              = var.https_ports_certs[count.index][0]
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.https_ports_certs[count.index][2]
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg-https[count.index].arn
  }
}

resource "aws_lb_target_group" "lb-tg-https" {
  count    = length(var.https_ports_certs)
  name     = "${var.name_prefix}-tg-https-${count.index}"
  port     = var.https_ports_certs[count.index][1]
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
  tags     = var.tags
}
