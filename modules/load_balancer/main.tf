resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = var.internal
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.security_group_ids

  tags = {
    Name = var.lb_name
  }
}

resource "aws_lb_target_group" "lb" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "lb" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb.arn
  }
}

resource "aws_lb_target_group_attachment" "lb" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.lb.arn
  target_id        = var.instance_ids[count.index]
  port             = var.target_group_port
}
