provider "helm" {}

# Configuration de Dockprom
resource "helm_release" "dockprom" {
  name       = "dockprom"
  repository = "https://stefanprodan.github.io/dockprom"
  chart      = "dockprom"
  version    = "0.1.0" # Spécifiez la version de Dockprom que vous souhaitez installer
}
