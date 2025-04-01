resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  version          = "v1.14.4"

  set {
    name  = "installCRDs"
    value = "true"
  }

  values = [
    file("${path.module}/values.yaml")
  ]
}

resource "kubectl_manifest" "cluster_issuers" {
  yaml_body = file("${path.module}/cluster-issuers.yaml")
  depends_on = [helm_release.cert_manager]
} 
