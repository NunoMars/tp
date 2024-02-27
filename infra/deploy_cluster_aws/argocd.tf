provider "helm" {}

# Configuration de Argo CD
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "3.30.5"

  # Options de valeurs par défaut (facultatif)
  values = [
    {
      "server" = {
        "service" = {
          "type" = "LoadBalancer"
        }
      }
    }
  ]
}
