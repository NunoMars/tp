
output "certificate_arn" {
  value = aws_acm_certificate.cert.arn
}

resource "aws_lb_listener" "eks_https_listener" {
  load_balancer_arn = aws_lb.eks_lb_site_voyance.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    target_group_arn = aws_lb_target_group.eks_target_group.arn
    type             = "forward"
  }

  certificate_arn = aws_acm_certificate.cert.arn
}

resource "aws_lb_listener_certificate" "eks_listener_cert" {
  listener_arn    = aws_lb_listener.eks_https_listener.arn
  certificate_arn = aws_acm_certificate.cert.arn

  depends_on = [
    aws_acm_certificate.cert
  ]
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "site-voyance.devops.oclock.school"
  validation_method = "DNS"
  # Ajoutez d'autres paramètres selon vos besoins, comme les tags, le cycle de vie, etc.
}


data "aws_route53_zone" "example" {
  name = "devops.oclock.school."
}

resource "aws_route53_record" "example" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example.zone_id
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
  # timeout = "45m" # optionnel
}
