resource "helm_release" "glance" {
  name             = "glance"
  chart            = "glance"
  repository       = "https://kubernetes-charts.storage.googleapis.com"
  namespace        = "glance"
  create_namespace = true
  version          = "3.2.2" # or latest stable you prefer

  values = [
    file("${path.module}/values.yaml")
  ]
}
