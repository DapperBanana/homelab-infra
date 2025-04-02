resource "helm_release" "glance" {
  name             = "glance"
  chart            = "glances"
  version          = "1.0.5"
  repository       = "https://sleighzy.github.io/helm-charts/" # Correct repository
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