data "aws_route53_zone" "parent_zone" {
  name = "devops.oclock.school"
}

output "parent_zone_id" {
  value = data.aws_route53_zone.parent_zone.zone_id
}

data "aws_lb" "k8s_lb_site_voyance" {
  name = "k8s-sitevoya-sitevoya-498512926f"
}
resource "aws_route53_record" "site_voyance_alias" {
  zone_id = data.aws_route53_zone.parent_zone.zone_id
  name    = "site-voyance.devops.oclock.school"
  type    = "A"
  alias {
    name                   = "${data.aws_lb.k8s_lb_site_voyance.dns_name}.eu-west-3.elb.amazonaws.com"
    zone_id                = data.aws_route53_zone.parent_zone.zone_id
    evaluate_target_health = true
  }
}
