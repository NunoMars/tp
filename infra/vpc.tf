# Création du VPC
resource "aws_vpc" "siteVoyance" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}
