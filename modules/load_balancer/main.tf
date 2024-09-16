resource "aws_lb" "this" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.security_group_id]
  tags = {
    Name = var.name
  }

}

resource "aws_lb_target_group" "nginx" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group_attachment" "nginx" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}
