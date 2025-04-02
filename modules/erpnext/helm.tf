resource "helm_release" "erpnext" {
  name             = "erpnext"
  chart            = "erpnext"
  repository       = "https://helm.erpnext.com"
  namespace        = "erpnext"
  create_namespace = true
  version          = "5.0.32"

  values = [
    file("${path.module}/values.yaml")
  ]
}