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

# Comment out or remove the original kubectl_manifest resource

# Add a local file resource to create a temporary manifest file
resource "local_file" "cluster_issuers" {
  content  = file("${path.module}/cluster-issuers.yaml")
  filename = "${path.module}/temp-cluster-issuers.yaml"
  depends_on = [helm_release.cert_manager]
}

# Use a null_resource with kubectl apply instead
resource "null_resource" "apply_cluster_issuers" {
  triggers = {
    manifest_sha1 = sha1(file("${path.module}/cluster-issuers.yaml"))
  }

  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/temp-cluster-issuers.yaml"
  }

  depends_on = [local_file.cluster_issuers, helm_release.cert_manager]
}