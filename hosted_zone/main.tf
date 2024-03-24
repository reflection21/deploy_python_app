variable "aws_lb_dns_name" {}
variable "aws_lb_zone_id" {}

data "aws_route53_zone" "reflection-21" {
  name         = "reflection-21.xyz"
  private_zone = false
}
resource "aws_route53_record" "lb_record" {
  zone_id = data.aws_route53_zone.reflection-21.zone_id
  name    = "www.reflection-21.xyz"
  type    = "A"

  alias {
    name                   = var.aws_lb_dns_name
    zone_id                = var.aws_lb_zone_id
    evaluate_target_health = true
  }
}
