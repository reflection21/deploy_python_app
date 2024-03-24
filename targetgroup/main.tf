variable "vpc_id" {}
variable "ec2_id" {}
output "target_id" {
  value = aws_lb_target_group.target_group.arn
}

resource "aws_lb_target_group" "target_group" {
  name     = "target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/health"
    port                = 5000
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200" # has to be HTTP 200 or fails
  }
}
resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.ec2_id
  port             = 5000
}
