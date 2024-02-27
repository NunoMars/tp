provider "aws" {
  region = "eu-west-3"
}

# Création du cluster EKS
resource "aws_eks_cluster" "cluster_site_voyance" {
  name     = "cluster_site_voyance" # Renommage du cluster
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      "subnet-07f1f0210c35befe2", # Subnet dans eu-west-3a
      "subnet-0c089616fb40a9075", # Subnet dans eu-west-3b
      "subnet-06ec69d301976b41e", # Subnet dans eu-west-3c
    ]
    security_group_ids = [
      "sg-0f268fe21efd7909d",
      "sg-0dfa8677d7e210094",
    ]
    vpc_id = "vpc-06ddc03d8f2f9bfdd" # Spécifiez l'ID de votre VPC ici
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_attachment
  ]
}

# Création du rôle IAM pour EKS
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

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

# Attachement d'une politique IAM au rôle pour EKS
resource "aws_iam_role_policy_attachment" "eks_cluster_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Ajout de l'accès au cluster EKS pour l'utilisateur spécifié
resource "aws_eks_cluster_authorization" "nunomars_access" {
  cluster_name = aws_eks_cluster.my_cluster.name
  role_arn     = "arn:aws:iam::339713030032:user/nunomars"
}

# Création d'un rôle IAM pour les instances EC2 du worker nodes
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attachement d'une politique IAM au rôle pour les instances EC2 du worker nodes
resource "aws_iam_role_policy_attachment" "eks_node_attachment" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Création d'un profil instance pour les instances EC2 du worker nodes
resource "aws_iam_instance_profile" "eks_node_profile" {
  name = "eks-node-profile"
  role = aws_iam_role.eks_node_role.name
}
