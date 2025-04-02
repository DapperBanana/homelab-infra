resource "helm_release" "erpnext" {
  name             = "erpnext"
  repository       = "https://helm.erpnext.com"
  chart            = "erpnext"
  version          = "5.0.32"
  namespace        = "erpnext"
  create_namespace = true
  
  values = [
    <<-EOT
      persistence:
        worker:
          storageClass: "local-path"  # Use the k3s default storage class
        logs:
          storageClass: "local-path"
        redis-queue:
          storageClass: "local-path"
        redis-cache:
          storageClass: "local-path"
        redis-socketio:
          storageClass: "local-path"
        mariadb:
          storageClass: "local-path"
    EOT
  ]
}