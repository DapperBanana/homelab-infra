resource "helm_release" "glance" {
  name             = "glance"
  repository       = "https://nicolargo.github.io/helm-charts" # Updated repository
  chart            = "glances"                                 # Chart name is "glances" not "glance"
  version          = "1.0.5"                                  # Use a recent version
  namespace        = "glance"
  create_namespace = true
  
  values = [
    <<-EOT
      glances:
        container_name: glance
        refresh_time: 5
        theme: default
        hide_top_bar: false
        port: 61208
      
      ingress:
        enabled: true
        className: traefik
        annotations:
          traefik.ingress.kubernetes.io/router.entrypoints: "websecure"
          traefik.ingress.kubernetes.io/router.tls: "true"
        hosts:
          - host: glance.austinlhoward.com
            paths:
              - path: /
                pathType: Prefix
        tls:
          - hosts:
              - glance.austinlhoward.com
            secretName: glance-tls
    EOT
  ]
}