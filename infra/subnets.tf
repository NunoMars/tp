# Création des sous-réseaux
resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.siteVoyance.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-3a"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "subnet-a"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.siteVoyance.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-3b"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "subnet-b"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "subnet_c" {
  vpc_id                  = aws_vpc.siteVoyance.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-west-3c"
  map_public_ip_on_launch = true

  tags = {
    Name                     = "subnet-c"
    "kubernetes.io/role/elb" = "1"
  }
}

