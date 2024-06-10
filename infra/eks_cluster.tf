# Création de la passerelle Internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.siteVoyance.id
}

# Création des tables de routage
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.siteVoyance.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Associer les sous-réseaux aux tables de routage
resource "aws_route_table_association" "subnet_a_association" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_b_association" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet_c_association" {
  subnet_id      = aws_subnet.subnet_c.id
  route_table_id = aws_route_table.route_table.id
}

# Création des groupes de sécurité
resource "aws_security_group" "eks_cluster_sg" {
  name        = "eks-cluster-sg"
  description = "Security group for EKS cluster"
  vpc_id      = aws_vpc.siteVoyance.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Update the EKS cluster configuration to enable API and ConfigMap authentication modes
resource "aws_eks_cluster" "cluster_site_voyance" {
  name     = "cluster_site_voyance"
  role_arn = aws_iam_role.cluster_site_voyance_role.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.subnet_a.id,
      aws_subnet.subnet_b.id,
      aws_subnet.subnet_c.id,
    ]
    security_group_ids = [
      aws_security_group.eks_cluster_sg.id
    ]
  }
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
  # Configuration of access configmap
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attachment
  ]
}

# Création du rôle IAM pour EKS
resource "aws_iam_role" "cluster_site_voyance_role" {
  name               = "cluster_site_voyance_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "eks.amazonaws.com",
          "ec2.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "cluster_site_voyance_role_policy_attachment" {
  role       = aws_iam_role.cluster_site_voyance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
resource "aws_iam_role_policy_attachment" "cluster_site_voyance_role_policy_attachment_2" {
  role       = aws_iam_role.cluster_site_voyance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "cluster_site_voyance_role_policy_attachment_3" {
  role       = aws_iam_role.cluster_site_voyance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "attach_policy_to_efs" {
  role       = aws_iam_role.cluster_site_voyance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
}
# Création d'une politique IAM personnalisée pour EKS
resource "aws_iam_policy" "eks_node_policy" {
  name        = "eks-node-policy"
  description = "IAM policy for EKS nodes"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:GetMetrics",
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeTags",
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVolumes",
        "ec2:CreateSecurityGroup",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:ModifyInstanceAttribute",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CreateInternetGateway",
        "ec2:CreateNatGateway",
        "ec2:CreateRoute",
        "ec2:CreateRouteTable",
        "ec2:AssociateRouteTable",
        "ec2:AttachInternetGateway",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteTags",
        "ec2:DeleteVolume",
        "ec2:DetachInternetGateway",
        "ec2:DisassociateRouteTable",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:DeleteRoute",
        "ec2:DeleteRouteTable",
        "ec2:DeleteNatGateway",
        "ec2:ReleaseAddress",
        "ec2:DescribeRouteTables",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeNatGateways",
        "ec2:DescribeAddresses",
        "ec2:DescribeVpcs",
        "ec2:DescribeAvailabilityZones",
        "elasticloadbalancing:DescribeListenerCertificates",
        "elasticloadbalancing:CreateRule",
        "elasticloadbalancing:DescribeRules",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:AddTags",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:DescribeLoadBalancerPolicies",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetGroupAttributes",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:CreateTargetGroup",
        "elasticloadbalancing:DeleteTargetGroup",
        "elasticloadbalancing:ModifyTargetGroup",
        "elasticloadbalancing:ModifyTargetGroupAttributes",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:SetIpAddressType",
        "elasticloadbalancing:SetSecurityGroups",
        "elasticloadbalancing:SetSubnets",
        "elasticloadbalancing:SetWebAcl",
        "elasticloadbalancing:CreateListener",
        "elasticloadbalancing:DeleteListener",
        "elasticloadbalancing:ConfigureHealthCheck",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "ec2:CreateVpc",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:DescribeSecurityGroups",
        "ec2:CreateSubnet",
        "ec2:CreateVolume",
        "ec2:DeleteVolume",
        "ec2:DetachVolume",
        "ec2:AttachVolume",
        "cloudwatch:GetMetricData",
        "cloudwatch:PutMetricAlarm",
        "cloudwatch:PutMetricData",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:DescribeSecurityGroups",
        "ec2:CreateSubnet",
        "ec2:CreateVolume",
        "ec2:DeleteVolume",
        "ec2:DetachVolume",
        "ec2:AttachVolume",
        "persistentvolumeclaims:create",
        "persistentvolumeclaims:get",
        "persistentvolumeclaims:list",
        "persistentvolumeclaims:delete",
        "persistentvolumes:create",
        "persistentvolumes:get",
        "persistentvolumes:list",
        "persistentvolumes:delete",
        "acm:ListCertificates",
        "acm:DescribeCertificate",
        "shield:GetSubscriptionState",
        "wafv2:GetWebACLForResource",
        "wafv2:GetWebACL",
        "wafv2:AssociateWebACL",
        "wafv2:DisassociateWebACL",
        "wafv2:ListResourcesForWebACL",
        "wafv2:ListWebACLs",
        "waf-regional:GetWebACLForResource"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

# Attachement de la politique IAM au rôle pour EKS
resource "aws_iam_role_policy_attachment" "eks_cluster_attachment" {
  role       = aws_iam_role.cluster_site_voyance_role.name
  policy_arn = aws_iam_policy.eks_node_policy.arn
}

resource "aws_eks_node_group" "cluster_site_voyance_node_goup_1" {
  cluster_name    = aws_eks_cluster.cluster_site_voyance.name
  node_group_name = "cluster_site_voyance_node_goup"
  node_role_arn   = aws_iam_role.cluster_site_voyance_role.arn


  subnet_ids = [
    aws_subnet.subnet_a.id,
    aws_subnet.subnet_b.id,
    aws_subnet.subnet_c.id,
  ]

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 0
  }
  instance_types = ["t2.small"]
  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.cluster_site_voyance,
    data.aws_lb.k8s_lb_site_voyance,
  ]
}


resource "aws_eks_node_group" "cluster_site_voyance_node_goup_2" {
  cluster_name    = aws_eks_cluster.cluster_site_voyance.name
  node_group_name = "cluster_site_voyance_node_goup_2"
  node_role_arn   = aws_iam_role.cluster_site_voyance_role.arn


  subnet_ids = [
    aws_subnet.subnet_a.id,
    aws_subnet.subnet_b.id,
    aws_subnet.subnet_c.id,
  ]

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 0
  }
  instance_types = ["t2.small"]
  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.cluster_site_voyance,
    data.aws_lb.k8s_lb_site_voyance,
  ]
}

resource "aws_eks_node_group" "cluster_site_voyance_node_goup_3" {
  cluster_name    = aws_eks_cluster.cluster_site_voyance.name
  node_group_name = "cluster_site_voyance_node_goup_3"
  node_role_arn   = aws_iam_role.cluster_site_voyance_role.arn


  subnet_ids = [
    aws_subnet.subnet_a.id,
    aws_subnet.subnet_b.id,
    aws_subnet.subnet_c.id,
  ]

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 0
  }
  instance_types = ["t2.small"]
  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.cluster_site_voyance,
    data.aws_lb.k8s_lb_site_voyance,
  ]
}
resource "aws_iam_role" "role" {
  name               = "eks-iam-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_access_entry" "my_eks_access_entry" {
  cluster_name  = aws_eks_cluster.cluster_site_voyance.name
  principal_arn = "arn:aws:iam::339713030032:user/nunomars"
}

resource "aws_eks_access_policy_association" "access_policy_association" {
  cluster_name  = aws_eks_cluster.cluster_site_voyance.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  principal_arn = "arn:aws:iam::339713030032:user/nunomars"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "access_policy_association_2" {
  cluster_name  = aws_eks_cluster.cluster_site_voyance.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::339713030032:user/nunomars"

  access_scope {
    type = "cluster"
  }
}

