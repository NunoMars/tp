provider "helm" {}

# Configuration de Helm
resource "helm_release" "helm" {
  name       = "helm"
  repository = "https://charts.helm.sh/stable"
  chart      = "helm"
  version    = "3.7.1"

  # Options de valeurs par défaut (facultatif)
  values = [
    {
      "image" = {
        "repository" = "nginx"
        "tag"        = "1.19.1"
      }
    }
  ]
}
