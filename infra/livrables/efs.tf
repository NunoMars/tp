resource "aws_efs_file_system" "efs" {
  creation_token = "cluster-site-voyance-efs"
  tags = {
    Name = "cluster-site-voyance-efs"
  }
}

resource "aws_efs_mount_target" "efs_mount" {
  count          = 3
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.subnet_b.id
  security_groups = [
    aws_security_group.eks_cluster_sg.id
  ]
}

# Attacher le système de fichiers EFS à un pod Kubernetes
resource "kubernetes_storage_class" "efs_storage_class" {
  metadata {
    name = "efs-storage-class-cluster-site-voyance"
  }

  storage_provisioner = "kubernetes.io/aws-efs"
  reclaim_policy      = "Retain"
}

resource "kubernetes_persistent_volume_claim" "efs_pvc" {
  metadata {
    name = "efs-pvc"
  }
  spec {
    access_modes       = ["ReadWriteMany"]
    storage_class_name = kubernetes_storage_class.efs_storage_class.metadata[0].name
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}
